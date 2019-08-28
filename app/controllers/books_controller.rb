class BooksController < ApplicationController
  def index
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @book = Book.new(book_params)
    if @bool.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end


  private
  def book_params
    params.require.permit(:title,:author,:synopsis,:image_url)
  end
end
