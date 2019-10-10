require 'rails_helper'

RSpec.describe Emotion, type: :model do
  describe 'バリデーション' do
    it '理由だけで登録出来る' do
      emotion = FactoryBot.build(:emotion)
      expect(emotion).to be_valid
    end

    it '理由がないと登録できない' do
      emotion = FactoryBot.build(:emotion, body: '')
      emotion.valid?
      expect(emotion.errors[:body]).to include("を入力してください")
    end

    it '理由とタグで登録出来る' do
      emotion = FactoryBot.build(:emotion, tag_list: '感動')
      expect(emotion).to be_valid
    end
  end
end
