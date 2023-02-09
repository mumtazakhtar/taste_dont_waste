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

    # If params or cookingtime or or diets is present
    if params[:query].present? || params[:cooking_time] || params[:diets]
      params[:cooking_time].to_i

      # Query AND cooking time AND diet present
      if params[:query].present? && params[:cooking_time] && params[:diets]
        @recipes = Recipe.where(sql_query, query: "%#{params[:query]}%").where("cooking_time <= ?", params[:cooking_time]).where("diets ILIKE ?", "%#{params[:diets]}%")

      # Query and cooking time
      elsif params[:query].present? && params[:cooking_time]
        @recipes = Recipe.where(sql_query, query: "%#{params[:query]}%").where("cooking_time <= ?", params[:cooking_time])

      # Diet and query
      elsif params[:diets] && params[:query].present?
        @recipes = Recipe.where(sql_query, query: "%#{params[:query]}%").where("diets ILIKE ?", "%#{params[:diets]}%")

      # Diet and cookingtime
      elsif params[:diets] && params[:cooking_time]
          @recipes = Recipe.where("cooking_time <= ?", params[:cooking_time]).where("diets ILIKE ?", "%#{params[:diets]}%")

      # Query present
      elsif params[:query].present?
        @recipes = Recipe.where(sql_query, query: "%#{params[:query]}%")

      # Cookingtime present
      elsif params[:cooking_time]
        @recipes = Recipe.where("cooking_time <= ?", params[:cooking_time])

      #  Diet present
      elsif params[:diets]
        @recipes = Recipe.where("diets ILIKE ?", "%#{params[:diets]}%")
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

  def sql_query
    sql_query = <<~SQL
          recipes.ingredients @@ :query
          OR recipes.title @@ :query
          SQL
    sql_query
  end

end
