require 'rails_helper'

describe 'ユーザーフォロー機能', type: :system do
  describe '本についての機能' do
    before do
      user_a = FactoryBot.create(:user)
      user_b = FactoryBot.create(:user, username: "テストユーザー2", email: "test@test2.com", password: "testpass2")
      FactoryBot.build(:book)
      visit new_user_session_path
      visit "/users/sign_in"
      fill_in 'user[email]', with: 'test@test.com'
      fill_in 'user[password]', with: 'testpass'
      click_button "ログイン"

      fill_in 'keyword', with: '星の王子'
      page.first(".el-button").click
      page.first(".best-btn").click
      fill_in 'emotion_body', with: '好きな本です'
      fill_in 'emotion_tag_list', with: '感動,笑える'
      click_on "登録"

      page.first(".fa-sign-out").click
      fill_in 'user[email]', with: 'test@test2.com'
      fill_in 'user[password]', with: 'testpass2'
      click_button "ログイン"
    end

    context 'user_aをフォローした時マイページに' do
      before do
        page.first(".fa-commenting").click
        page.first(".emotion__follow__link").click
      end

      it 'フォローユーザの好きな本が表示される' do
        page.first(".fa-user").click
        page.first(".tab2").click
        expect(page).to have_content '星の王子'
      end

      it 'フォロ-解除した時、好きな本は表示されない' do
        page.first(".emotion__follow__link").click
        page.first(".fa-user").click
        page.first(".tab2").click
        expect(page).not_to have_content '星の王子'
      end
    end
  end
end
