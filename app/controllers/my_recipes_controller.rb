class MyRecipesController < ApplicationController
  # skip_after_action :verify_authorized
  before_action :set_recipe_id, only: %i[show edit update destroy]
  before_action :authorize_my_recipe

  def index
    @my_recipes = policy_scope(MyRecipe)
    @my_recipes = MyRecipe.all
  end

  def show
  end

  def new
    @my_recipe = MyRecipe.new
  end

  def create
    @my_recipe = MyRecipe.new(recipe_params)
    if @my_recipe.save
      redirect_to root_path, notice: 'Created a new recipe in your cookbook'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @my_recipe.update(recipe_params)
      redirect_to root_path, notice: 'Updated succesfully'
    else
      render :edit, status: unprocessable_entity
    end
  end

  def destroy
    @my_recipe.destroy
    redirect_to root_path, notice: 'Deleted successfully'
  end

  private

  def set_recipe_id
    @horse = Horse.find(params[:id])
  end

  def recipe_params
    params.require(:my_recipe).permit(:title, :ingredients, :cookingTime, :description)
  end

  def authorize_my_recipe
    authorize @my_recipe
  end

end
