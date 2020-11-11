class PurchasesController < ApplicationController
  before_action :item_find_params, only: [:index, :create]
  def index
    @user_purchase = UserPurchase.new
  end

  def create
    @user_purchase = UserPurchase.new(purchase_params)
    if @user_purchase.valid?
      @user_purchase.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def item_find_params
    @item = Item.find(params[:item_id])
  end

  def purchase_params
    params.require(:user_purchase).permit(
      :delivery_postal_code_id,
      :delivery_prefectures_id,
      :delivery_city,
      :delivery_address,
      :delivery_building,
      :delivery_phone_number
    ).merge(user_id: current_user.id, item_id: @item.id)
  end
end