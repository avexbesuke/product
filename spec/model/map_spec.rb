require 'rails_helper'

RSpec.describe Map, type: :model do
  describe 'バリデーション' do
    it '登録できる' do
      map = FactoryBot.build(:map)
      expect(map).to be_valid
    end

    it 'book_idがないと登録出来ない' do
      map = FactoryBot.build(:map, book_id: "")
      map.valid?
      expect(map.errors[:book_id]).to include("を入力してください")
    end

    it 'user_idがないと登録出来ない' do
      map = FactoryBot.build(:map, user_id: "")
      map.valid?
      expect(map.errors[:user_id]).to include("を入力してください")
    end
  end
end
