class PurchasesController < ApplicationController
  before_action :item_find_params, only: [:index, :create]
  before_action :authenticate_user!, only: [:index, :create]
  before_action :move_root, only: [:index, :create]

  def index
    @user_purchase = UserPurchase.new
  end

  def create
    @user_purchase = UserPurchase.new(purchase_params)
    if @user_purchase.valid?
      pay_item
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
    ).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.selling_price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end

  def move_root
    redirect_to root_path unless current_user.id != @item.user_id || Purchase.find_by(item_id: @item.id).nil?
  end
end
