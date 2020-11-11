class UserPurchase
  include ActiveModel::Model
  VALID_POSTAL_CODE_REGEX = /\A\d{3}[-]\d{4}\z/
  VALID_PHONE_NUMBER_REGEX = /\A\d{1,11}\z/

  attr_accessor :delivery_postal_code_id,
                :delivery_prefectures_id,
                :delivery_city, :delivery_address,
                :delivery_building,
                :delivery_phone_number,
                :user_id,
                :item_id

  with_options presence: true do
    validates :delivery_postal_code_id, format: { with: VALID_POSTAL_CODE_REGEX, message: 'にはハイフンが必要であること' }
    validates :delivery_prefectures_id, numericality: { other_than: 1 }
    validates :delivery_city
    validates :delivery_address
    validates :delivery_phone_number, format: { with: VALID_PHONE_NUMBER_REGEX, message: 'にはハイフンは不要で、11桁以内であること' }
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(
      delivery_postal_code_id: delivery_postal_code_id,
      delivery_prefectures_id: delivery_prefectures_id,
      delivery_city: delivery_city,
      delivery_address: delivery_address,
      delivery_building: delivery_building,
      delivery_phone_number: delivery_phone_number,
      purchase_id: purchase.id
    )
  end

end