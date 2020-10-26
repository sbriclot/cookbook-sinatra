class Recipe
  attr_reader :name, :description, :prep_time, :rating

  def initialize(name, description, prep_time, rating, done = false)
    @name = name
    @description = description
    @prep_time = prep_time
    @rating = rating
    @done = done
  end

  def done?
    @done
  end

  def done!
    @done = true
  end
end
