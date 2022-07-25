require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative 'cookbook'
require_relative 'recipe'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get "/" do
  erb :index
end

get "/about" do
  @toto = "toto"
  erb :about
end

get "/team/:username" do
  puts params[:username]
  "The username is #{params[:username]}"
end

get "/cookbook" do
  @recipes = Cookbook.new('recipes.csv').all
  erb :cookbook
end

get "/new" do
  erb :new
end

post "/new_recipe" do
  recipe = Recipe.new(params[:name], params[:description], params[:rating], params[:prep_time])
  Cookbook.new('recipes.csv').add_recipe(recipe)
  redirect to '/cookbook'
end

get "/destroy" do
  @recipes = Cookbook.new('recipes.csv').all
  erb :destroy
end

post "/destroy_index" do
  Cookbook.new('recipes.csv').remove_recipe(params[:index].to_i)
  redirect to '/cookbook'
end
