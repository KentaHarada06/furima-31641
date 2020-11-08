FactoryBot.define do
  factory :item do
    name                       { 'テスト商品' }
    description                { 'テスト説明です' }
    category_id                { '2' }
    state_id                   { '2' }
    delivery_charge_burden_id  { '2' }
    delivery_source_id         { '2' }
    delivery_time_id           { '2' }
    selling_price              { '500' }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
