class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user_emotions =  User.find(params[:id]).emotions.page(params[:page]).per(10)
  end

  def index
  end
end