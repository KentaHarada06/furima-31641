class Item < ApplicationRecord
  with_options presence:true do
    validates :name
    validates :description
    validates :category_id
    validates :state_id
    validates :delivery_charge_burden_id
    validates :delivery_source_id
    validates :delivery_time_id
    validates :selling_price
    validates :user
  end
  belongs_to :user
  has_one_attached :image
end
