class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :skip_authorization

  def toggle_favorite
    @recipe = Recipe.find_by(id: params[:id])
    current_user.favorited?(@recipe) ? current_user.unfavorite(@recipe) : current_user.favorite(@recipe)
  end

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
    redirect_back(fallback_location: root_path)
    # flash[:success] = "Post created successfully."
    # redirect_to recipe_path(@recipe), notice: "Recipe was saved to your cookbook."
  end

  def unfavorite
    @recipe = Recipe.find(params[:id])
    current_user.unfavorite(@recipe)
    # flash[:success] = "Post created successfully."
    redirect_back(fallback_location: root_path)
    # redirect_to recipe_path(@recipe), notice: "Recipe was unfavorited."
  end
end
