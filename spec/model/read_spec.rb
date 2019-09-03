require 'rails_helper'

RSpec.describe Read, type: :model do
  it "読書履歴(model:readのレコード)を生成できる" do
    read = FactoryBot.create(:read)
    expect(read).to be_valid
  end
end
