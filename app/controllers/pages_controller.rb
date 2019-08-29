class PagesController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    @readed_books = @user.read_books.limit(3)
    @fast_best_book = @user.books.first
    @fast_best_emotion = @user.emotions.first
  end
end
