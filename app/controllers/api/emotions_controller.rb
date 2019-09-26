class Api::EmotionsController < ApplicationController
  protect_from_forgery :except => [:create, :index] 
  
  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to home_index_path
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def index
    @books = Book.pluck(:bid)
  end

  private
    def book_params
      params.require(:books).permit(:title,:image,:author,
        :description,:body,:readed_at,:bid)
    end
end