class BooksController < ApplicationController
  def show
    @book = Book.find(params[:id])
    @other_user = @book.users.limit(5)
    @other_books = []
    @other_user.each do |user|
      while true
        other_book = user.books.order("RAND()").limit(1)
        if other_book[0].id != params[:id].to_i
          @other_books.push(other_book)
          break
        else user.books.length == 0
          break
        end
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
