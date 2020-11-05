FactoryBot.define do
  factory :user do
    nickname              {"テストコード"}
    email                 {"testcode@gmail.com"}
    password              {"testcode1"}
    password_confirmation {password}
    kanji_first_name      {"山田"}
    kanji_last_name       {"太郎"}
    kana_first_name       {"ヤマダ"}
    kana_last_name        {"タロウ"}
    birthdate             {"1=>2000,2=>1,3=>1"}
  end
end