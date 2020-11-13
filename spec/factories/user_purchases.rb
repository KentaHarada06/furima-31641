FactoryBot.define do
  factory :user_purchase do
    delivery_postal_code_id { '123-4567' }
    delivery_prefectures_id { 2 }
    delivery_city { '杉並区' }
    delivery_address { '1-1' }
    delivery_building { '東京ハイツ' }
    delivery_phone_number { '09000000000' }
    token { 'tok_0000000000' }
  end
end
