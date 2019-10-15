require 'rails_helper'

describe '本を好きな理由投稿機能', type: :system do
  describe '理由' do
    before do
      user_a = FactoryBot.create(:user, email: "karimen@karimen.com", password: "karimen@karimen.com")
      FactoryBot.build(:book)

      visit new_user_session_path
      click_button "簡単ログイン"
    end

    context '本をマイベストにした時' do
      it "理由がないとマイベストにできない", retry: 3 do
        fill_in 'keyword', with: '星の王子'
        page.first(".el-button").click
        page.first(".best-btn").click
        fill_in 'emotion_body', with: ''
        fill_in 'emotion_tag_list', with: '感動,笑える'
        click_on "登録"
        expect(page).to have_content 'この本が好きな理由'
      end

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

      it 'マイベスト一覧から検索が出来る', retry: 3 do
        page.first(".fa-commenting").click
        fill_in 'q_body_or_book_author_or_book_title_cont', with: '好きな本です'
        page.first(".fa-search").click
        expect(page).to have_content '好きな本です'
      end

      it 'マイページに理由が表示される', retry: 3 do
        page.first(".fa-bookmark").click
        expect(page).to have_content '好きな本です'
      end

      it 'マイページにタグが表示される', retry: 3 do
        page.first(".fa-bookmark").click
        expect(page).to have_content '感動'
      end

      it '編集した時に本文が変わる', retry: 3 do
        page.first(".fa-bookmark").click
        page.first(".fa-edit").click
        fill_in 'emotion_body', with: '良き本です'
        click_on "決定"
        page.first(".fa-bookmark").click
        expect(page).to have_content '良き本です'
      end

      it '編集した時に理由がないとエラーメッセージ表示', retry: 3 do
        page.first(".fa-bookmark").click
        page.first(".fa-edit").click
        fill_in 'emotion_body', with: ''
        click_on "決定"
        expect(page).to have_content '好きな理由を入力してください'
      end

      it '削除した時に表示されない', retry: 3 do
        page.first(".fa-bookmark").click
        page.first(".fa-trash").click
        expect(page).not_to have_content '良き本です'
      end
    end

    context '本を検索して読書ボタンを付けた時', retry: 3 do
      before do
        fill_in 'keyword', with: '星の王子'
        page.first(".el-button").click
        page.first(".read-btn").click
      end

      it '読書履歴からマイベストの登録出来る', retry: 3 do
        page.first(".fa-history").click
        click_on "マイベストにする!"
        fill_in 'emotion_body', with: '好きな本です'
        click_on "登録"
        expect(page).to have_content '好きな本です'
      end
    end
  end
end
