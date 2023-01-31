class MyRecipesController < ApplicationController
  before_action :authorize_my_recipe

  def index
    @my_recipes = policy_scope(MyRecipe)
    @my_recipes = MyRecipe.all
  end

  def new
    @my_recipe = MyRecipe.new
  end

  def create
    @my_recipe = MyRecipe.new(recipe_params)
    @my_recipe.save
    redirect_to root_path
  end

  def edit

  end

  def update
  end

  def destroy
  end

  private

  def set_recipe_id
    @horse = Horse.find(params[:id])
  end

  def recipe_params
    params.require(:my_recipe).permit(:title, :ingredients, :cookingTime, :description)
  end

  def update
  end

  def destroy
  end

  private

  def authorize_my_recipe
    authorize @my_recipe
  end
end
