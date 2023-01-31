class MyRecipesController < ApplicationController
  # skip_after_action :verify_authorized
  before_action :authorize_my_recipe

  def index
    @my_recipes = policy_scope(MyRecipe)
  end

  def create
  end

  def show
  end

  def edit
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
