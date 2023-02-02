class ItemsController < ApplicationController
  before_action :set_item_id, only: %i[edit update destroy]
  before_action :authorize_my_item, only: %i[edit update destroy]

  def index
    @items = policy_scope(Item)
    @items = Item.find_by(user_id: user.id).all
    # add a sort by function
  end

  def new
    @item = Item.new
    authorize @item
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    authorize @item
    if @item.save
      redirect_to cookbook_path, notice: 'Item added succesfully'
      # it now directs to the cookbook_path, but if the user is on the recipe index
      # will it also be able to create an item? and then it should maybe be directed to
      # the recipe_path?
    else
      render :new, status: unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to cookbook_path, notice: 'Updated succesfully'
    else
      render :edit, status: unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to items_path, notice: 'Deleted succesfully'
  end

  private

  def set_item_id
    @item = Item.find(params[:id])
  end

  def authorize_my_item
    authorize @item
  end

  def item_params
    params.require(:item).permit(:product, :bestByDate, :stock)
  end
end
