class ItemsController < ApplicationController
  before_action :item_find_params, only: [:show, :edit, :update, :destroy]
  before_action :move_new_user_session, only: [:new, :edit]
  before_action :move_root, only: [:edit, :destroy]

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
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_find_params
    @item = Item.find(params[:id])
  end

  def move_root
    redirect_to root_path unless current_user.id == @item.user_id || Purchase.find_by(item_id: @item.id).nil?
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
