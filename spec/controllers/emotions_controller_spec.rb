require 'rails_helper'

RSpec.describe EmotionsController, type: :request do
  describe 'GET #index' do
    it 'indexに遷移するか' do
      get emotions_path
      expect(response).to render_template :index
    end
  end

  describe 'GET #edit' do
    it "emotionを@emotionに割り当て" do
      emotion = FactoryBot.create(:emotion)
      get edit_emotion_path(emotion.id)
      expect(assigns(:emotion)).to eq emotion
    end

    it "editテンプレートをレンダリング" do
      emotion = FactoryBot.create(:emotion)
      get edit_emotion_path(emotion.id)
      expect(response).to render_template :edit
    end
  end
end
