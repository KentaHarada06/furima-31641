## users

|Column               |Type    |Options                   |
| ------------------- | ------ | -----------------------  |
| email               | string | null: false unique: true |
| password            | string | null: false              |
| encrypted_password  | string | null: false              |
| nickname            | string | null: false              |
| kanji_first_name    | string | null: false              |
| kanji_last_name     | string | null: false              |
| kana_first_name     | string | null: false              |
| kana_last_name      | string | null: false              |
| birthdate           | date   | null: false              |

### Association
- has_many :items
- has_many :purchases

## items

| Column                 | Type       | Options                        |
| ---------------------- | ------     | ------------------------------ |
| name                   | string     | null: false                    |
| description            | text       | null: false                    |
| category_id            | integer    | null: false                    |
| state_id               | integer    | null: false                    |
| delivery_charge_burden | integer    | null: false                    |
| delivery_source        | integer    | null: false                    |
| delivery_time          | integer    | null: false                    |
| selling_price          | integer    | null: false                    |
| user                   | references | null: false, foreign_key: true |

### Association
- has_one :purchase
- belongs_to :user

## purchases

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :address

## addresses

| Column                | Type       | Options                        |
| --------------------- | ---------- | ------------------------------ |
| delivery_postal_code  | string     | null: false                    |
| delivery_prefectures  | integer    | null: false                    |
| delivery_city         | string     | null: false                    |
| delivery_address      | string     | null: false                    |
| delivery_building     | string     |                                |
| delivery_phone_number | string     | null: false                    |
| purchase              | references | null: false, foreign_key: true |

### Association
- belongs_to :purchase
