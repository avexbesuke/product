class RelationshipsController < ApplicationController
  def create
    user = User.find(current_user.id)
    if User.find(params[:user_id]).followed_by?(current_user)
      follow_cancel = current_user.active_relationships.find_by(follower_id: params[:user_id])
      follow_cancel.destroy
    else
      follow_do = current_user.active_relationships.new(follower_id: params[:user_id])
      follow_do.save
    end
  end
end
