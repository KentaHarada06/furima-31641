class ItemsController < ApplicationController
  before_action :move_new_user_session, only: [:new, :edit]
  before_action :move_root, only: [:edit]

  def index
    @item = Item.all.order(created_at: 'DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render new_item_path
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  private

  def move_root
    redirect_to root_path unless current_user.id == Item.find(params[:id]).user_id
  end

  def move_new_user_session
    redirect_to new_user_session_path unless user_signed_in?
  end

  def item_params
    params.require(:item).permit(
      :image,
      :name,
      :description,
      :category_id,
      :state_id,
      :delivery_charge_burden_id,
      :delivery_source_id,
      :delivery_time_id,
      :selling_price
    ).merge(user_id: current_user.id)
  end
end
