class Map < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  has_many_attached :images

  belongs_to :user
  belongs_to :book
end
