class Map < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  has_many_attached :images

  belongs_to :user
  belongs_to :book

  validate :file_type
  validate :image_size
  validates :book_id, presence: true
  validates :user_id, presence: true

  private

  def image_size
    if images.each do |image|
         errors.add(:images, '1メガバイト以上は添付できません。') if image.blob.byte_size > 1.megabytes
       end
    end
  end

  def file_type
    if images.each do |image|
         errors.add(:image, 'needs to be a JPEG or PNG') unless image.content_type.in?(%('image/jpeg image/png'))
       end
    end
  end
end
