class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :skip_authorization

  def toggle_favorite
    @recipe = Recipe.find_by(id: params[:id])
    current_user.favorited?(@recipe) ? current_user.unfavorite(@recipe) : current_user.favorite(@recipe)
  end

  def index
    @recipes = Recipe.all
    @search_ingredients = params[:query]

    if params[:query].present?
      @recipes = Recipe.search_by_everything(params[:query])
    end

    if params[:cooking_time].present?
      case params[:cooking_time]
      when "30" then @recipes = Recipe.short_time
      when "45" then @recipes = Recipe.medium_time
      when "60" then @recipes = Recipe.long_time
      else @recipes = Recipe.all
      # else @recipes = Recipe.search_by_cooking_time(params[:cooking_time])
      end
    end

    @items = policy_scope(Item)
  end

  def show
    @recipe = Recipe.find(params[:id])
    @ingredients = JSON.parse(@recipe.ingredients)
    @instructions = JSON.parse(@recipe.description)
  end

  def favorite
    @recipe = Recipe.find(params[:id])
    current_user.favorite(@recipe)
    redirect_back_or_to 'fallback_location: root_path', alert: "Saved recipe to your cookbook."
  end

  def unfavorite
    @recipe = Recipe.find(params[:id])
    current_user.unfavorite(@recipe)
    redirect_back_or_to 'fallback_location: root_path', alert: "Removed recipe from your cookbook."
  end

end
