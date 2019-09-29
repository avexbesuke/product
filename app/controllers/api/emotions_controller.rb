class Api::EmotionsController < ApplicationController
  protect_from_forgery except: %i[create index]

  def create
    @book = Book.new(book_params)
    @book.image_url = 'noimage.png' if @book.image_url.empty?
    @book.save if Book.where(bid: @book.bid).empty?
    book_id = Book.find_by(bid: book_params[:bid]).id
    @emotion = Emotion.new(emotion_params)
    @emotion.book_id = book_id
    if @emotion.save
      redirect_to user_path(@emotion.user.id)
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def index
    @books = current_user.books.pluck(:bid)
  end

  private

  def book_params
    params.require(:books).permit(:title, :image_url, :author,
                                  :synopsis, :readed_at, :bid)
  end

  def emotion_params
    params.require(:books).permit(:body, :tag_list).merge(user_id: current_user.id)
  end
end
