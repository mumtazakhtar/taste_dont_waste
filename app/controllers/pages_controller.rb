class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def cookbook
    @cookbook_recipes = current_user.all_favorited + current_user.my_recipes
  end

end
