class MyRecipesController < ApplicationController
  skip_after_action :verify_authorized

end
