require 'rails_helper'

describe '聖地巡礼機能', type: :system do
  describe '理由' do
    before do
      user_a = FactoryBot.create(:user, email: "karimen@karimen.com", password: "karimen@karimen.com")
      FactoryBot.build(:book)

      visit new_user_session_path
      click_button "簡単ログイン"
    end

    context '思い出の場所を投稿した時' do
      before do
        page.first(".fa-map").click
        page.first(".fa-map").click
        page.driver.click(260, 390)
        page.driver.click(260, 390)
        fill_in 'map[memori]', with: '最高！'
        click_on "投稿"
      end

      it '聖地巡礼に本のタイトルが表示される' do
        expect(page).to have_content '星の王子'
      end
    end
  end
end