class UsersController < ApplicationController
  def show
    @user_books    = current_user.books
    @user_emotions = current_user.emotions
    @i = 0
  end
end