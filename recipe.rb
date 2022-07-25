class Recipe
  attr_reader :name, :description, :rating, :done, :prep

  def initialize(name, description, rating, prep, done = "To Do")
    @name = name
    @description = description
    @rating = rating
    @done = done
    @prep = prep
  end

  def done!
    @done = "Done"
  end

  def undone!
    @done = "To Do"
  end
end
