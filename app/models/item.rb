class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :state
  belongs_to :delivery_charge_burden
  belongs_to :delivery_source
  belongs_to :delivery_time

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

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :state_id
    validates :delivery_charge_burden_id
    validates :delivery_source_id
    validates :delivery_time_id
  end

  belongs_to :user
  has_one_attached :image
end
