class ItemsController < ApplicationController
  before_action :move_new_user_session, only: [:new]

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

  private

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
