require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it 'メルーアドレスとパスワードがあれば登録できる' do
      user = FactoryBot.create(:user)
      expect(user).to be_valid
    end

    it 'メールアドレスがないと登録できない' do
      user = FactoryBot.build(:user, email: '')
      user.valid?
      expect(user.errors[:email]).to include("が入力されていません。")
    end

    it 'パスウワードがないと登録できない' do
      user = FactoryBot.build(:user, password: '')
      user.valid?
      expect(user.errors[:password]).to include("が入力されていません。")
    end

    it 'パスワードが5文字以下だと登録できない' do
      user = FactoryBot.build(:user, password: '12345')
      user.valid?
      expect(user.errors[:password][0]).to include("は6文字以上に設定して下さい。")
    end

    it 'パスワードが6文字以上だと登録できる' do
      user = FactoryBot.build(:user, password: '1234567')
      expect(user).to be_valid
    end

    it '重複したemailがあると登録できない' do
      user = FactoryBot.create(:user)
      another_user = FactoryBot.build(:user)
      another_user.valid?
      expect(another_user.errors[:email][0]).to include("既に使用されています。")
    end
  end
end
