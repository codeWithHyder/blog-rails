class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def new
    @current_user = current_user
    @post = Post.new
  end

  def create
    @post = Post.new(post_params.merge(user_id: current_user.id, comment_counter: 0, likes_counter: 0))

    if @post.save
      redirect_to user_post_path(current_user, @post), notice: 'Post created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
    @comments = Comment.where(post_id: params[:id])
  end

  def include_user
    @user = User.includes(:posts, posts: [:comments, { comments: [:author] }]).find(params[:user_id])
  end

  def destroy
    @post = Post.find(params[:id])
    authorize! :destroy, @post

    @post.destroy
    redirect_to posts_path, notice: 'Post deleted successfully.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
