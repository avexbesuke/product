class Emotion < ApplicationRecord
  validates :body, presence: true

  belongs_to :user, dependent: :destroy
  belongs_to :book, dependent: :destroy

  acts_as_taggable
end
