require 'rails_helper'

describe '本を好きなわけ機能', type: :system do
  describe 'わけ登録' do
    before do
      user_a = FactoryBot.create(:user)
      FactoryBot.build(:book)

      visit new_user_session_path
      fill_in 'user_email', with: 'test@test.com'
      fill_in 'user_password', with: 'testpass'
      click_button "ログイン"
    end

    context '本をマイベストにした時' do
      before do
        fill_in 'keyword', with: '星の王子'
        page.first(".fa-search").click
        page.first(".best-btn").click
        fill_in 'emotion_body', with: '好きな本です'
        fill_in 'emotion_tag_list', with: '感動,笑える'
        click_on "commit"
      end

      it 'マイベストにわけが表示される' do
        expect(page).to have_content '好きな本です'
      end

      it 'マイベストにタグが表示される' do
        expect(page).to have_content '感動'
      end
    end
  end
end
