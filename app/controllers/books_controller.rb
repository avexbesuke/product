class BooksController < ApplicationController
  def show
    @book = Book.find(params[:id])
    @other_user = @book.users.order("RAND()").limit(5)
    @other_books = []
    @other_user.each do |user|
      if user.books.length != 0
        other_book = user.books.where.not(id: params[:id].to_i).order("RAND()").limit(1)
        @other_books.push(other_book)
      end
    end
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

end
