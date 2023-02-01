class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def cookbook
    @cookbook_recipes = user.all_favorited + user.my_recipes
  end

end
