require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @recipes = []
    @csv_file = csv_file_path

    load_cookbook
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_cookbook
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_cookbook
  end

  def done_recipe(index)
    recipe = @recipes[index]
    return unless recipe

    recipe.done!

    save_cookbook
  end

  private

  def load_cookbook
    CSV.foreach(@csv_file) do |row|
      # Here, row is an array of columns
      @recipes << Recipe.new(row[0], row[1], row[2], row[3], row[4] == "true")
    end
  end

  def save_cookbook
    CSV.open(@csv_file, 'wb') do |csv|
      @recipes.each { |recipe| csv << [recipe.name, recipe.description, recipe.prep_time, recipe.rating, recipe.done?] }
    end
  end
end
