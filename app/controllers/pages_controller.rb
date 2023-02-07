class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def cookbook
    @cookbook_recipes = current_user.all_favorited + current_user.my_recipes
    # Replaced items.all by policy scope item (pundit for displaying only users own items)
    @items = policy_scope(Item).order(bestByDate: :asc)
    # @items = Item.all
    # @items = Item.order(bestByDate: :asc)
    @recipes_favorite = current_user.all_favorited
    @recipes_created = current_user.my_recipes
    # @days = DateTime.now - Date.bestByDate
  end

end
