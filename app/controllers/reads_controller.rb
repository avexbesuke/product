class ReadsController < ApplicationController
  def create
    @book = Book.new(book_params)
    if Book.where(title: @book.title).length == 0
      @book.save
    end
    book = Book.find_by(title: params[:title])
    
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
    @user_read_books = current_user.read_books.order("created_at DESC").page(params[:page]).per(12)
  end

  private
  def book_params
    params.permit(:title,:author,:synopsis,:image_url)
  end
end
