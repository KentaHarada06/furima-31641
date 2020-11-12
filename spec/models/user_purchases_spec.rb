require 'rails_helper'

RSpec.describe UserPurchase, type: :model do
  describe '寄付情報の保存' do
    before do
        @user_purchase = FactoryBot.build(:user_purchase)
      end
      context '商品購入処理がうまくいくとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@user_purchase).to be_valid
      end
      it 'delivery_postal_code_idにハイフンが含まれていれば保存できること' do
        @user_purchase.delivery_postal_code_id = '123-4567'
        expect(@user_purchase).to be_valid
      end
      it 'delivery_buildingが空でも保存できること' do
        @user_purchase.delivery_building = nil
        expect(@user_purchase).to be_valid
      end
      it 'delivery_phone_numberに11桁以内の値が含まれていると保存できること' do
        @user_purchase.delivery_phone_number = '09012345678'
        expect(@user_purchase).to be_valid
      end
    end

    describe '商品購入処理がうまくいかないとき' do
      it "tokenが空では登録できないこと" do
        @user_purchase.token = nil
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("Token can't be blank")
      end
      it 'delivery_postal_code_idが空だと保存できないこと' do
        @user_purchase.delivery_postal_code_id = nil
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("Delivery postal code can't be blank")
      end
      it 'delivery_postal_code_idにハイフンが含まれていないと保存できないこと' do
        @user_purchase.delivery_postal_code_id = '1234567'
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("Delivery postal code にはハイフンが必要であること")
      end
      it 'delivery_cityが空だと保存できないこと' do
        @user_purchase.delivery_city = nil
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("Delivery city can't be blank")
      end
      it 'delivery_addressが空だと保存できないこと' do
        @user_purchase.delivery_address = nil
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("Delivery address can't be blank")
      end
      it 'delivery_phone_numberが空だと保存できないこと' do
        @user_purchase.delivery_phone_number = nil
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("Delivery phone number can't be blank")
      end
      it 'delivery_phone_numberに12桁以上の値が含まれていると保存できないこと' do
        @user_purchase.delivery_phone_number = '090123456789'
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("Delivery phone number にはハイフンは不要で、11桁以内であること")
      end
    end
  end
end