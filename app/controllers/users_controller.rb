class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:comments)
    @post_counter = @posts.count
  end

  def index
    @users = User.all
  end
end
