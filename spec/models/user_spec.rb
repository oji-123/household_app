require 'rails_helper'

RSpec.describe User, type: :model do
  before do 
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    it 'nicknameが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Nickname can't be blank"
    end
    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end
    it 'emailが他ユーザーのものと同一の際は登録ができない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include "Email has already been taken"
    end
    it 'emailに「@」が含まれていないと登録できない' do 
      @user.email = "test123gmail.com"
      @user.valid?
      expect(@user.errors.full_messages).to include "Email is invalid"
    end
    it 'passwordが空では登録ができない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end
    it 'passwordとpasswordとpassword_confirmationが不一致では登録ができない' do
      other_password_user = FactoryBot.build(:user)
      @user.password = other_password_user.password
      @user.valid?
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end
    it 'passwordが5文字以下では登録できない' do
      @user.password = "aaa11"
      @user.valid?
      expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
    end
    it 'passwordが英字のみでは登録できない' do
      @user.password = "aaaaaa"
      @user.valid?
      expect(@user.errors.full_messages).to include "Password is invalid"
    end
    it 'passwordが数字のみでは登録できない' do
      @user.password = "111111"
      @user.valid?
      expect(@user.errors.full_messages).to include "Password is invalid"
    end
    it 'pair_idはUserテーブル内に該当ユーザーが存在しないと登録できない' do
      main_user = FactoryBot.create(:user)
      pair_user = FactoryBot.create(:user)
      main_user.pair_id = pair_user.id
      pair_user.delete
      main_user.valid?
      expect(main_user.errors.full_messages).to include "Pair is invalid"
    end
  end
  
end
