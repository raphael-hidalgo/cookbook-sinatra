require 'csv'
require_relative 'recipe'

class Cookbook
  attr_reader :csv_path

  def initialize(csv_file_path)
    @csv_path = csv_file_path
    @recipes = []
    CSV.foreach(csv_file_path) { |row| @recipes << Recipe.new(row[0], row[1], row[2], row[3], row[4]) }
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe

    CSV.open(@csv_path, 'a') do |csv|
      csv << [recipe.name, recipe.description, recipe.rating, recipe.prep, recipe.done]
    end
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)

    CSV.open(@csv_path, 'wb') do |csv|
      @recipes.each { |recipe| csv << [recipe.name, recipe.description, recipe.rating, recipe.prep, recipe.done] }
    end
  end

  def recipe_done(recipe_index)
    @recipes[recipe_index].done!
    CSV.open(@csv_path, 'wb') do |csv|
      @recipes.each { |recipe| csv << [recipe.name, recipe.description, recipe.rating, recipe.prep, recipe.done] }
    end
  end

  def recipe_undone(recipe_index)
    @recipes[recipe_index].undone!
    CSV.open(@csv_path, 'wb') do |csv|
      @recipes.each { |recipe| csv << [recipe.name, recipe.description, recipe.rating, recipe.prep, recipe.done] }
    end
  end
end
