require 'rails_helper'

RSpec.describe Relationship, type: :model do
  it "フォローレコードを生成出来る" do
    user1 = FactoryBot.build(:user)
    user2 = FactoryBot.build(:user, email: 'test@test.com2', password: "testpass2")
    relationship = FactoryBot.build(:relationship, following: user1, follower: user2)
    expect(relationship).to be_valid
  end
end
