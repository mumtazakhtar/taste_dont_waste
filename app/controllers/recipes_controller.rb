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

    # Should seach ingredients AND title? Also search 'like' and prefix etc?
    if params[:query] || params[:cooking_time]
      params[:cooking_time].to_i
      if params[:query] && params[:cooking_time]
        @recipes = Recipe.where("cooking_time <= ?", params[:cooking_time]).where("ingredients like ?", "%#{params[:query]}%")
      elsif params[:query]
        @recipes = Recipe.where("ingredients like ?", "%#{params[:query]}%")
      elsif params[:cooking_time]
        @recipes = Recipe.where("cooking_time <= ?", params[:cooking_time])
      else
        @recipes = Recipe.all
      end
    end

      # @recipes = Recipe.joins(:ingredients, :cooking_time) # the columns to filter
      # @recipes = Recipe.search_by_everything(params[:query]) if params[:query] # your pg_scope

    # if params[:query] && params[:cooking_time]
    #   @recipes = Recipe.joins(:ingredients, :cooking_time) # the columns to filter
    #   @recipes = Recipe.search_by_everything(params[:query]).where("cooking_time <= ?", params[:cooking_time].to_i) if params[:query] && params[:cooking_time]
    # end

    # :next_five_tasks, ->(user) { where(user_id: user.id).where("due_date > ?", Date.today).where("category != ?", "Complete").order(:due_date).limit(5)}scope :next_five_tasks, ->(user) { where(user_id: user.id).where("due_date > ?", Date.today).where("category != ?", "Complete").order(:due_date).limit(5)}

    # @recipes = @recipes.ingredients_search(params[:query]) if params[:query].present?
    # @recipes = @recipes.ingredients_search(params[:cooking_time]) if params[:cooking_time].present?
    # @recipes = @recipes.global_search(params[:query]) if params[:query] && params[:cooking_time].present?

        #     case params[:cooking_time]
    #     when "30" then @time_recipes << Recipe.short_time
    #     when "45" then @time_recipes << Recipe.medium_time
    #     when "60" then @time_recipes << Recipe.long_time
    #     when "120" then @time_recipes << Recipe.longest_time
    #     end

    # @name_recipes = []
    # @time_recipes = []
    # if params[:query].present?
    #   @name_recipes << Recipe.search_by_everything(params[:query])
    #   # @name_recipes << Recipe.where(ingredients: params[:query])
    #   @recipes = []
    #   (@recipes << @name_recipes).flatten
    # end

    # if params[:cooking_time].present?
    #   if params[:query].present?
    #     case params[:cooking_time]
    #     when "30" then @time_recipes << Recipe.short_time
    #     when "45" then @time_recipes << Recipe.medium_time
    #     when "60" then @time_recipes << Recipe.long_time
    #     when "120" then @time_recipes << Recipe.longest_time
    #     end
    #     @recipes.delete_if { |recipe| recipe != @time_recipes.any? }
    #   else
    #     @recipes = []
    #     case params[:cooking_time]
    #     when "30" then @time_recipes << Recipe.short_time
    #     when "45" then @time_recipes << Recipe.medium_time
    #     when "60" then @time_recipes << Recipe.long_time
    #     when "120" then @time_recipes << Recipe.longest_time
    #     end
    #   end
    #   (@recipes << @time_recipes).flatten
    # end

    # @recipes.to_a.flatten!

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
