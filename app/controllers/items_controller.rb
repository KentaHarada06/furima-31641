class ItemsController < ApplicationController
  def index
  end

  def new
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def create
  end

  private

  def message_params
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
