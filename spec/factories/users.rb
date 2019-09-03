FactoryBot.define do
  factory :user do
    username { "テストユーザ" }
    email    { "test@test.com" }
    password { "testpass" }
  end
end
