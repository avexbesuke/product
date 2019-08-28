class BooksController < ApplicationController
  def show
    @book = Book.find(params[:id])
  end

  def new
  end

  def index
    if params[:keyword].present?
      url = 'https://www.googleapis.com/books/v1/volumes?q='
      request = url + params[:keyword]
      enc_str = URI.encode(request)
      uri = URI.parse(enc_str)
      json = Net::HTTP.get(uri)
      @books = JSON.parse(json)
    else
      @books = 'なし'
    end
  end

  def create
  end


  private
  def book_params
    params.require.permit(:title,:author,:synopsis,:image_url)
  end
end
