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

    # For after search is empties (after deselecting ingredients etc)
    if params[:query].blank?
      @recipes = Recipe.all

    # For search function for ingredients and cooking time
    elsif params[:query] || params[:cooking_time] || params[:diets]
      params[:cooking_time].to_i

      # If all three (ingredients, cookingtime, diet) are present
      if params[:query] && params[:cooking_time] && params[:diets]
        sql_query = <<~SQL
          recipes.ingredients @@ :query
          OR recipes.title @@ :query
        SQL
        @recipes = Recipe.where(sql_query, query: "%#{params[:query]}%").where("cooking_time <= ?", params[:cooking_time]).where("diets ILIKE ?", "%#{params[:diets]}%")

      # If two (ingredients and cooking time) are present
      elsif params[:query] && params[:cooking_time]
        sql_query = <<~SQL
          recipes.ingredients @@ :query
          OR recipes.title @@ :query
        SQL
        @recipes = Recipe.where(sql_query, query: "%#{params[:query]}%").where("cooking_time <= ?", params[:cooking_time])

      # if qtwo (ingredients and cooking time) are present
      elsif params[:diets] && params[:query]
        sql_query = <<~SQL
          recipes.ingredients @@ :query
          OR recipes.title @@ :query
        SQL
        @recipes = Recipe.where(sql_query, query: "%#{params[:query]}%").where("diets ILIKE ?", "%#{params[:diets]}%")

      # if two (cooking time and diet) are present
      elsif params[:diets] && params[:cooking_time]
          @recipes = Recipe.where("cooking_time <= ?", params[:cooking_time]).where("diets ILIKE ?", "%#{params[:diets]}%")

      # if only one (ingredients) is present
      elsif params[:query]
        # @recipes = @recipes.where("ingredients ILIKE ?", "%#{params[:query]}%")
        sql_query = <<~SQL
          recipes.ingredients @@ :query
          OR recipes.title @@ :query
        SQL
        @recipes = Recipe.where(sql_query, query: "%#{params[:query]}%")

      # if only cooking time is present
      elsif params[:cooking_time]
        @recipes = Recipe.where("cooking_time <= ?", params[:cooking_time])

      # if only diet is present
      elsif params[:diets]
        @recipes = Recipe.where("diets ILIKE ?", "%#{params[:diets]}%")
      # tryout for number of ingredients
        # elsif params[:ingredients]
        #   @recipes = Recipe.where("#{ingredients.count} <= ?", params[:ingredients].to_i)
      else
        @recipes = Recipe.all
      end

      # Possible refactoring try for later
      # @recipes2 = Recipe.joins(:recipes_ingredients, :cooking_time, :diets, :id)
      # @recipes = Recipe.where("ingredients ilike ?", "%#{params[:query]}%") if params[:query].present?
      # @recipes = Recipe.where("cooking_time <= ?", params[:cooking_time]) if params[:cooking_time].present?
      # @recipes = Recipe.where("diets like ?", "%#{params[:diets]}%") if params[:diets].present?

      # Please leave this in
      # @recipes = Recipe.where("cooking_time <= ?", params[:cooking_time]).where("ingredients ILIKE ?", "%#{params[:query]}%")
      # @recipes = Recipe.where("cooking_time <= ?", params[:cooking_time]).where("ingredients ILIKE ?", "%#{params[:query]}%")

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
