class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    if params[:query].present?
      @recipes = Recipe.search_by_everything(params[:query])
    else
      # Do we want to display all recipes on the index recipe page?
      @recipes = Recipe.all
    end
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

end
