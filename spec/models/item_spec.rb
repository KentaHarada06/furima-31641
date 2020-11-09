require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品情報の登録がうまくいくとき' do
      it '商品出品ページ内全ての入力項目が存在すれば登録できる' do
        expect(@item).to be_valid
      end
      it '価格の範囲が、¥300以上であれば登録できる' do
        @item.selling_price = 300
        expect(@item).to be_valid
      end
      it '価格の範囲が、¥9,999,999以下であれば登録できる' do
        @item.selling_price = 9_999_999
        expect(@item).to be_valid
      end
      it '販売価格は半角数字のみであれば登録できる' do
        @item.selling_price = 1000
        expect(@item).to be_valid
      end
    end

    context '商品情報の登録がうまくいかないとき' do
      it '商品画像が空だと登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が空では登録できない' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it '商品の説明が空では登録できない' do
        @item.description = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'カテゴリーの情報が空では登録できない' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'カテゴリーの情報が初期値(id = 1)では登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1')
      end
      it '商品の状態が空では登録できない' do
        @item.state_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("State can't be blank")
      end
      it '商品の状態が初期値(id = 1)では登録できない' do
        @item.state_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('State must be other than 1')
      end
      it '配送料の負担が空では登録できない' do
        @item.delivery_charge_burden_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery charge burden can't be blank")
      end
      it '配送料の負担が初期値(id = 1)では登録できない' do
        @item.delivery_charge_burden_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery charge burden must be other than 1')
      end
      it '発送元の地域が空では登録できない' do
        @item.delivery_source_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery source can't be blank")
      end
      it '発送元の地域が初期値(id = 1)では登録できない' do
        @item.delivery_source_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery source must be other than 1')
      end
      it '発送までの日数が空では登録できない' do
        @item.delivery_time_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery time can't be blank")
      end
      it '発送までの日数が初期値(id = 1)では登録できない' do
        @item.delivery_time_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery time must be other than 1')
      end
      it '販売価格が空では登録できない' do
        @item.selling_price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Selling price can't be blank")
      end
      it '販売価格が半角数字以外では登録できない' do
        @item.selling_price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price is not a number')
      end
      it '販売価格が¥300未満であれば登録できない' do
        @item.selling_price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price must be greater than or equal to 300')
      end
      it '販売価格が¥9,999,999超過であれば登録できない' do
        @item.selling_price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price must be less than or equal to 9999999')
      end
    end
  end
end
