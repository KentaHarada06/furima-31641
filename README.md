## users

|Column            |Type    |Options                   |
| ---------------- | ------ | -----------------------  |
| email            | string | null: false unique: true |
| password         | string | null: false              |
| nickname         | string | null: false              |
| kanji_first_name | string | null: false              |
| kanji_last_name  | string | null: false              |
| kana_first_name  | string | null: false              |
| kana_last_name   | string | null: false              |
| birthdate_year   | int    | null: false              |
| birthdate_month  | int    | null: false              |
| birthdate_date   | int    | null: false              |

### Association
- has_many :items
- has_many :purchases

## items

| Column                 | Type       | Options                        |
| ---------------------- | ------     | ------------------------------ |
| item_name              | string     | null: false                    |
| item_description       | text       | null: false                    |
| item_state             | string     | null: false                    |
| delivery_charge_burden | string     | null: false                    |
| delivery_source        | string     | null: false                    |
| delivery_time          | string     | null: false                    |
| selling_price          | int        | null: false                    |
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
| delivery_postal_code  | int        | null: false                    |
| delivery_prefectures  | string     | null: false                    |
| delivery_city         | string     | null: false                    |
| delivery_address      | string     | null: false                    |
| delivery_building     | string     |                                |
| delivery_phone_number | int        | null: false                    |
| purchase              | references | null: false, foreign_key: true |

### Association
- belongs_to :purchase
