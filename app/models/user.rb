class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :emotions, dependent: :destroy
  has_many :books, through: :emotions, dependent: :destroy

  has_many :reads
  has_many :read_books, through: :reads, source: :book

  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower

  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  has_many :maps
  has_many :map_books, through: :maps, source: :book

  has_one_attached :image

  def user_mybest?(_book)
    current_user.book
  end

  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  validate :file_type, on: :update
  validate :image_size, on: :update

  private

  def image_size
    if image.attached?
      errors.add(:images, '1メガバイト以上は添付できません。') if image.blob.byte_size > 1.megabytes
    end
  end

  def file_type
    if image.attached?
      errors.add(:image, 'needs to be a JPEG or PNG') unless image.content_type.in?(%('image/jpeg image/png'))
    end
  end
end
