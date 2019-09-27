class Api::ReadsController < ApplicationController
  protect_from_forgery :except => [:create] 
  
  def create
    @book = Book.new(book_params)
    @book.image_url = 'noimage.png' if @book.image_url.length == 0
    @book.save if Book.where(bid: @book.bid).empty?
    book = Book.find_by(bid: book_params[:bid])

    if book.reads.where(user_id: current_user.id).exists?
      read = current_user.reads.find_by(book_id: book.id)
      read.destroy
      render json: book.id, status: 200
    else
      read = current_user.reads.new(book_id: book.id)
      read.save
      render json: book.id, status: 200
    end
  end

  def index
    @reads = current_user.read_books.pluck(:bid)
  end
  
  private
    def book_params
      params.require(:books).permit(:title,:image_url,:author,
        :synopsis,:readed_at,:bid)
    end
end