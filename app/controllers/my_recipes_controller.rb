class MyRecipesController < ApplicationController
  # skip_after_action :verify_authorized
  # after_action :authorize_my_recipe, except: %i[index]
  before_action :set_recipe_id, only: %i[show edit update destroy]

  def index
    @my_recipes = MyRecipe.all
    @my_recipes = policy_scope(MyRecipe)
  end

  def show
    authorize @my_recipe
  end

  def new
    @my_recipe = MyRecipe.new
    authorize @my_recipe
  end

  def create
    @my_recipe = MyRecipe.new(recipe_params)
    @my_recipe.user = current_user
    authorize @my_recipe
    if @my_recipe.save
      redirect_to my_recipe_path(@my_recipe), notice: 'Created a new recipe in your cookbook'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @my_recipe
  end

  def update
    authorize @my_recipe
    if @my_recipe.update(recipe_params)
      redirect_to my_recipe_path, notice: 'Updated succesfully'
    else
      render :edit, status: unprocessable_entity
    end
  end

  def destroy
    authorize @my_recipe
    @my_recipe.destroy
    redirect_to root_path, notice: 'Deleted successfully'
  end

  private

  def set_recipe_id
    @my_recipe = MyRecipe.find(params[:id])
  end

  def recipe_params
    params.require(:my_recipe).permit(:title, :ingredients, :cookingTime, :description, :photo)
  end

end
