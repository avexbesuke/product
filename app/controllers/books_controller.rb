class BooksController < ApplicationController
  def show
    @book = Book.find(params[:id])
    @other_users = []
    @book.users.each do |user|
      if user.books.length > 1
        @other_users.push(user)
      end
    end
    @other_books = []
    5.times do
      if @other_users.length == 0
        break
      end
      user = @other_users.sample
      other_book = user.books.where.not(id: params[:id].to_i).order("RAND()").limit(1)
      @other_books.push(other_book)
      @other_users.delete(user)
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
