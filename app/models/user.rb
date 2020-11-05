class User < ApplicationRecord

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i
  VALID_KANJI_NAME_REGEX = /\A[ぁ-んァ-ン一-龥]+\z/
  VALID_KANA_NAME_REGEX = /\A[ァ-ン]+\z/

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'パスワードは、半角英数字混合で入力してください' }
         validates :nickname, presence: true
         validates :kanji_first_name, presence: true, format: { with: VALID_KANJI_NAME_REGEX, message: 'ユーザー本名は、全角（漢字・ひらがな・カタカナ）で入力してください' }
         validates :kanji_last_name, presence: true, format: { with: VALID_KANJI_NAME_REGEX, message: 'ユーザー本名は、全角（漢字・ひらがな・カタカナ）で入力してください' }
         validates :kana_first_name, presence: true, format: { with: VALID_KANA_NAME_REGEX, message: 'ユーザー本名のフリガナは、全角（カタカナ）で入力してください' }
         validates :kana_last_name, presence: true, format: { with: VALID_KANA_NAME_REGEX, message: 'ユーザー本名のフリガナは、全角（カタカナ）で入力してください' }
         validates :birthdate, presence: true

end