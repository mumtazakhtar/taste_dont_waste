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

    if params[:cookingTime].present?
      case params[:cookingTime]
      when "30" then @recipes = Recipe.where(cookingTime: 0..31)
      when "45" then @recipes = Recipe.where(cookingTime: 0..46)
      when "60" then @recipes = Recipe.where(cookingTime: 0..61)
      else @recipes = Recipe.all
      # else @recipes = Recipe.search_by_cookingtime(params[:cookingTime])
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

  private

  # def short_time
  #   @recipes = Recipe.all
  #   shorttime_recipes = []
  #   @recipes.each do |recipe|
  #     shorttime_recipes.push(recipe) if recipe.cookingTime <= 30
  #   end
  #   return shorttime_recipes
  # end
end
