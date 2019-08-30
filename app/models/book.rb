class Book < ApplicationRecord
  has_many :emotions, dependent: :destroy
  has_many :users, through: :emotions
  has_many :reads
  has_many :read_users, through: :reads, source: :user

  def read?(book, user)
    book.reads.find_by(user_id: user.id)
  end

  def readed_by?(user)
    Read.where(user_id: user.id).exists?
  end

end
