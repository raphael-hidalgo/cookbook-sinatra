require_relative 'cookbook'
require_relative 'recipe'
require_relative 'parsing'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
  end

  def list
    @cookbook.all
  end

  def create(args_1, args_2, args_3, args_4)
    recipe = Recipe.new(args_1, args_2, args_3, args_4)
    @cookbook.add_recipe(recipe)
  end

  def destroy
    recipe_number = @view.ask_for_index - 1
    @cookbook.remove_recipe(recipe_number)
  end

  def scrape
    ingredient = @view.ask_for_ingredient
    parsing = Parsing.new(ingredient)
    _recipes = parsing.scrape
    index = @view.display_top5(parsing.name, parsing.rating, parsing.description) - 1
    @cookbook.add_recipe(Recipe.new(parsing.name[index], parsing.description[index], parsing.rating[index], parsing.scrape_prep(parsing.urls[index])))
  end

  def mark_as_done
    @view.display(@cookbook.all)
    puts "\n\n"
    index = @view.ask_for_index_done - 1
    @cookbook.recipe_done(index)
  end

  def mark_as_undone
    @view.display(@cookbook.all)
    puts "\n\n"
    index = @view.ask_for_index_undone - 1
    @cookbook.recipe_undone(index)
  end
end
