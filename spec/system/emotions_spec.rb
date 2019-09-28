require 'rails_helper'

describe '本を好きな理由投稿機能', type: :system do
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
        page.first(".el-button").click

        page.first(".best-btn").click
        fill_in 'emotion_body', with: '好きな本です'
        fill_in 'emotion_tag_list', with: '感動,笑える'
        click_on "登録"
      end

      it 'マイベスト一覧に理由が表示される' do
        visit emotions_path
        expect(page).to have_content '好きな本です'
      end

      it 'マイベスト一覧にタグが表示される' do
        page.first(".fa-commenting").click
        expect(page).to have_content '感動'
      end

      it 'マイページに理由が表示される' do
        page.first(".fa-bookmark").click
        expect(page).to have_content '好きな本です'
      end

      it 'マイページにタグが表示される' do
        page.first(".fa-bookmark").click
        expect(page).to have_content '感動'
      end

      it '削除した時に表示されない' do
        page.first(".fa-bookmark").click
        expect(page).to have_content '感動'
      end
    end
  end
end
