class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :emotions, dependent: :destroy
  has_many :books, through: :emotions
  
  has_many :reads
  has_many :read_books, through: :reads, source: :book

  def user_mybest?(target)
    current_user.book
  end
end
