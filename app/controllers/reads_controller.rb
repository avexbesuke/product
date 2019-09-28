class ReadsController < ApplicationController
  def index
    @user_read_books = current_user.read_books.order("created_at DESC").page(params[:page]).per(12)
  end

  private

  def book_params
    params.permit(:title, :author, :synopsis, :image_url)
  end
end
