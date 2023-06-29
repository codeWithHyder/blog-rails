class LikesController < ApplicationController
  def create
    @user = User.find(params[:user_id])

    if @user.user_has_liked?(params[:post_id])
      @user.remove_user_like(params[:post_id])
    else
      @user.add_user_like(params[:post_id])
    end

    redirect_to user_post_path(user_id: params[:user_id], id: params[:post_id])
  end
end
