FactoryBot.define do
  factory :map do
    address { '日本、〒606-0806 京都府京都市左京区下鴨蓼倉町７６−６' }
    latitude {35.0395}
    longitude {135.774}
    book
    user
  end
end