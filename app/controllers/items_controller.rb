class ItemsController < ApplicationController
  before_action :authorize_my_item, except: :index

  def index
    @my_items = policy_scope(Item)
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def authorize_my_item
    authorize @my_item
  end
end
