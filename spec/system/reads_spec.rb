require 'rails_helper'

describe '読書ボタン機能', type: :system do
  describe '読んだ本をマーク' do
    before do
      user_a = FactoryBot.create(:user, email: "karimen@karimen.com", password: "karimen@karimen.com")
      FactoryBot.build(:book)

      visit new_user_session_path
      click_button "簡単ログイン"
    end

    context '本を検索して読書ボタンを付けた時' do
      before do
        fill_in 'keyword', with: '星の王子'
        page.first(".el-button").click
        page.first(".read-btn").click
      end

      it '読書マークを付けたら読書履歴に本が表示される' do
        page.first(".fa-history").click
        expect(page).to have_content '星の王子'
      end

      it 'マイページに読書履歴が表示される' do
        page.first(".fa-user").click
        expect(page).to have_content '星の王子'
      end

      it '読書履歴から本を削除出来る' do
        fill_in 'keyword', with: '星の王子'
        page.first(".el-button").click
        page.first(".read-btn").click
        page.first(".fa-history").click
        expect(page).not_to have_content '星の王子'
      end
    end
  end
end
