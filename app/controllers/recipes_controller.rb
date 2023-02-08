class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :skip_authorization

  def toggle_favorite
    @recipe = Recipe.find_by(id: params[:id])
    current_user.favorited?(@recipe) ? current_user.unfavorite(@recipe) : current_user.favorite(@recipe)
  end

  def index
    @search_ingredients = params[:query]
    @recipes = Recipe.all

    # if params[:query] || params[:cooking_time] || params[:diets]
    #   @recipes = Recipe.where('ingredients LIKE ? OR diets LIKE ?', "%#{params[:query]}%", "%#{params[:diets]}%")
    # else
    #   @recipes = Recipe.all
    # end

    # @recipes2 = Recipe.joins(:recipes_ingredients, :cooking_time, :diets, :id)
    # @recipes = @recipes2.where("ingredients ilike ?", "%#{params[:query]}%") if params[:query].present?
    # @recipes = @recipes2.where("cooking_time <= ?", params[:cooking_time]) if params[:cooking_time].present?
    # @recipes = @recipes2.where("diets like ?", "%#{params[:diets]}%") if params[:diets].present?



    # For search function for ingredients and cooking time
    if params[:query] || params[:cooking_time] || params[:diets]
      params[:cooking_time].to_i
      # If all three are present
      if params[:query] && params[:cooking_time] && params[:diets]
        @recipes = Recipe.where("cooking_time <= ?", params[:cooking_time]).where("ingredients ilike ?", "%#{params[:query]}%").where("diets like ?", "%#{params[:diets]}%")
      # If query (ingredients) and cooking time are present
      elsif params[:query] && params[:cooking_time]
        @recipes = Recipe.where("cooking_time <= ?", params[:cooking_time]).where("ingredients ilike ?", "%#{params[:query]}%")
      # if query (ingredients) and diet are present
      elsif params[:diets] && params[:query]
        @recipes = Recipe.where("diets like ?", "%#{params[:diets]}%").where("ingredients ilike ?", "%#{params[:query]}%")
      # if diet and cooking time are present
      elsif params[:diets] && params[:cooking_time]
          @recipes = Recipe.where("cooking_time <= ?", params[:cooking_time]).where("diets like ?", "%#{params[:diets]}%")
      # if only ingredient query is present
      elsif params[:query]
        @recipes = Recipe.where("ingredients ilike ?", "%#{params[:query]}%")
      # if only cooking time is present
      elsif params[:cooking_time]
        @recipes = Recipe.where("cooking_time <= ?", params[:cooking_time])
      # if only diet is present
      elsif params[:diets]
        @recipes = Recipe.where("diets like ?", "%#{params[:diets]}%")
      else
        @recipes = Recipe.all
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
