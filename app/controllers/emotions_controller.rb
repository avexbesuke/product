class EmotionsController < ApplicationController
  def new
  end

  def create
    @book = Book.new(book_params)
    if Book.where(title: @book.title).length == 0
      @book.save
    end
    book_id = Book.find_by(title: params[:title]).id
    @emotion = Emotion.new(emotion_params)
    @emotion.book_id = book_id

    if @emotion.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def emotion_params
    params.permit(:body).merge(user_id: current_user.id)
  end

  def book_params
    params.permit(:title,:author,:image_url,:synopsis)
  end
end
