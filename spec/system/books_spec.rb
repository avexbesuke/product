require 'rails_helper'

describe '本の機能', type: :system do
  describe '本についての機能' do
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

      it 'マイベスト一覧から検索が出来る' do
        page.first(".fa-commenting").click
        fill_in 'q_body_or_book_title_cont', with: '好きな本です'
        page.first(".fa-search").click
        expect(page).to have_content '好きな本です'
      end

      it 'マイページに理由が表示される' do
        page.first(".fa-bookmark").click
        expect(page).to have_content '好きな本です'
      end

      it 'マイページにタグが表示される' do
        page.first(".fa-bookmark").click
        expect(page).to have_content '感動'
      end

      it '編集した時に本文が変わる' do
        page.first(".fa-bookmark").click
        page.first(".fa-edit").click
        fill_in 'emotion_body', with: '良き本です'
        click_on "決定"
        page.first(".fa-bookmark").click
        expect(page).to have_content '良き本です'
      end

      it '削除した時に表示されない' do
        page.first(".fa-bookmark").click
        page.first(".fa-trash").click
        expect(page).not_to have_content '良き本です'
      end
    end
  end
end
