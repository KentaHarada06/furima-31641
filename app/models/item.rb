class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  MINIMAM_AMOUNT = 300
  MAXIMAM_AMOUNT = 9_999_999

  belongs_to :category
  belongs_to :state
  belongs_to :delivery_charge_burden
  belongs_to :delivery_source
  belongs_to :delivery_time

  with_options presence: true do
    validates :name
    validates :description
    with_options numericality: { other_than: 1 } do
      validates :category_id
      validates :state_id
      validates :delivery_charge_burden_id
      validates :delivery_source_id
      validates :delivery_time_id
    end
    validates :selling_price, numericality: { greater_than_or_equal_to: MINIMAM_AMOUNT, less_than_or_equal_to: MAXIMAM_AMOUNT }
    validates :image
  end

  belongs_to :user
  has_one_attached :image
end
