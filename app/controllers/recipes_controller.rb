class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def favorite
    @recipe = Recipe.find(params[:id])
    current_user.favorite(@recipe)
  end

  def unfavorite
    @recipe = Recipe.find(params[:id])
    current_user.unfavorite(@recipe)
  end

  def all_favorited
    current_user.all_favorited
  end

end
