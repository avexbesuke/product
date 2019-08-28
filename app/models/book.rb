class Book < ApplicationRecord
  has_many :emotions, dependent: :destroy
  has_many :users, through: :emotions
end
