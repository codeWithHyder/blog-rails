class CommentsController < ApplicationController
  load_and_authorize_resource

  def new
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = params[:user_id]
    @comment.post_id = params[:post_id]

    if @comment.save
      redirect_to user_post_path(user_id: params[:user_id], id: params[:post_id]), notice: 'Comment added successfully'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to user_post_path(user_id: params[:user_id], id: params[:post_id]),
                notice: 'Comment deleted successfully'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
