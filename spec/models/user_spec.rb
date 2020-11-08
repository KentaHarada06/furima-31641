require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it '新規登録ページ内全ての入力項目が存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上かつ半角英数字混合であれば登録できる' do
        @user.password = 'abc123'
        @user.password_confirmation = 'abc123'
        expect(@user).to be_valid
      end
      it 'ユーザー本名は全角（漢字・ひらがな・カタカナ）であれば登録できる' do
        @user.kanji_last_name = '田中'
        @user.kanji_first_name = 'タロウ'
        expect(@user).to be_valid
      end
      it 'ユーザー本名のフリガナは全角（カタカナ）であれば登録できる' do
        @user.kanji_last_name = 'タナカ'
        @user.kanji_first_name = 'タロウ'
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailに＠が含まれない場合登録できない' do
        @user.email = 'testgmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下であれば登録できない' do
        @user.password = 'abc12'
        @user.password_confirmation = 'abc12'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが半角英字のみでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は、半角英数字混合で入力してください')
      end
      it 'passwordが半角数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は、半角英数字混合で入力してください')
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordとpassword_confirmationの値が不一致では登録できない' do
        @user.password = 'abc123'
        @user.password_confirmation = '123abc'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'kanji_last_nameが空では登録できない' do
        @user.kanji_last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kanji last name can't be blank")
      end
      it 'kanji_last_nameは全角（漢字・ひらがな・カタカナ）でなければ登録できない' do
        @user.kanji_last_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kanji last name は、全角（漢字・ひらがな・カタカナ）で入力してください')
      end
      it 'kanji_first_nameが空では登録できない' do
        @user.kanji_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kanji first name can't be blank")
      end
      it 'kanji_first_nameは全角（漢字・ひらがな・カタカナ）でなければ登録できない' do
        @user.kanji_first_name = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kanji first name は、全角（漢字・ひらがな・カタカナ）で入力してください')
      end
      it 'kana_last_nameが空では登録できない' do
        @user.kana_last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana last name can't be blank")
      end
      it 'kana_last_nameのフリガナは全角（カタカナ）でなければ登録できない' do
        @user.kana_last_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana last name は、全角（カタカナ）で入力してください')
      end
      it 'kana_first_nameが空では登録できない' do
        @user.kana_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana first name can't be blank")
      end
      it 'kana_last_nameのフリガナは全角（カタカナ）でなければ登録できない' do
        @user.kana_first_name = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana first name は、全角（カタカナ）で入力してください')
      end
      it 'birthdateが空では登録できない' do
        @user.birthdate = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthdate can't be blank")
      end
    end
  end
end
