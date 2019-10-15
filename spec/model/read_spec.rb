require 'rails_helper'

RSpec.describe Read, type: :model do
  it "読書履歴(model:readのレコード)を生成できる" do
    read = FactoryBot.build(:read)
    expect(read).to be_valid
  end

  it 'book_idがないと登録出来ない' do
    read = FactoryBot.build(:read, book_id: "")
    read.valid?
    expect(read.errors[:book_id]).to include("を入力してください")
  end

  it 'user_idがないと登録出来ない' do
    read = FactoryBot.build(:read, user_id: "")
    read.valid?
    expect(read.errors[:user_id]).to include("を入力してください")
  end
end
