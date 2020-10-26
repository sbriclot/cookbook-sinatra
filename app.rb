require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require 'csv'
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

require_relative 'cookbook'
require_relative 'recipe'

CSV_FILE = File.dirname(__FILE__) + "/recipes.csv"

get '/' do
  cookbook = Cookbook.new(CSV_FILE)
  @recipes = cookbook.all
  erb :index
end

get '/new' do
  erb :new
end

post '/new_recipe' do
  name = params[:name]
  description = params[:description]
  prep_time = params[:prep_time]
  rate = params[:rate]

  cookbook = Cookbook.new(CSV_FILE)
  recipe = Recipe.new(name, description, prep_time, rate)
  cookbook.add_recipe(recipe)

  redirect '/'
end

get '/delete/:index' do
  cookbook = Cookbook.new(CSV_FILE)
  cookbook.remove_recipe(params[:index].to_i)

  redirect '/'
end

get '/done/:index' do
  cookbook = Cookbook.new(CSV_FILE)
  cookbook.done_recipe(params[:index].to_i)

  redirect '/'
end