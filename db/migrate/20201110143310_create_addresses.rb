class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :delivery_postal_code_id,          null: false
      t.integer :delivery_prefectures_id,         null: false
      t.string :delivery_city,                    null: false
      t.string :delivery_address,                 null: false
      t.string :delivery_building
      t.string :delivery_phone_number,            null: false
      t.references :purchase,                     null: false, foreign_key: true
      t.timestamps
    end
  end
end
