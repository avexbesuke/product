require 'rails_helper'

describe '本の機能', type: :system do
  describe '本についての機能',:retry => 3  do
    before do
      user_a = FactoryBot.create(:user)
      FactoryBot.build(:book)

      visit new_user_session_path
      fill_in 'user_email', with: 'test@test.com'
      fill_in 'user_password', with: 'testpass'
      click_button "ログイン"
    end

    context '本を検索した時' do
      before do
        fill_in 'keyword', with: '星の王子'
        page.first(".el-button").click
      end
      it '星の王子様が表示される' do
        expect(page).to have_content '星の王子さま'
      end
    end

    context '本に読書マークをつけた時' do
      before do
        fill_in 'keyword', with: '星の王子'
        page.first(".fa-search").click
        page.first(".read-btn").click
        page.first(".fa-history").click
      end

      it 'あなたが読んだ本に星の王子さまが表示される' do
        expect(page).to have_content '星の王子さま'
      end
    end
    
  end
end
