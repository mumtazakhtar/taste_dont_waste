class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @recipes = Recipe.all
    # @recipes = policy_scope(M
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
