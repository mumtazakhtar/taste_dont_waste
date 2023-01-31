class MyRecipesController < ApplicationController
  skip_after_action :verify_authorized
  
  def index
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
=======
  skip_after_action :verify_authorized

>>>>>>> master
end
