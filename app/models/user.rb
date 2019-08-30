class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :emotions, dependent: :destroy
  has_many :books, through: :emotions
  
  has_many :reads
  has_many :read_books, through: :reads, source: :book

  has_many :active_relationships, class_name: "Relationship",foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower

  has_many :passive_relationships, class_name: "Relationship",foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  def user_mybest?(book)
    current_user.book
  end

  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end
end
