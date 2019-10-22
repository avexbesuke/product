class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user_emotions = User.find(params[:id]).emotions.order("created_at DESC").page(params[:page]).per(Settings.number[:page_show_num])
  end

end