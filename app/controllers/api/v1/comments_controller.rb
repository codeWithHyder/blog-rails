module Api
  module V1
    class CommentsController < ApplicationController
      def index
        post = Post.find(params[:post_id])
        comments = post.comments

        render json: comments
      end

      def create
        post = Post.find(params[:post_id])
        comment = post.comments.new(comment_params)

        if comment.save
          render json: comment, status: :created
        else
          render json: comment.errors, status: :unprocessable_entity
        end
      end

      private

      def comment_params
        params.require(:comment).permit(:content).merge(user_id: current_user.id)
      end
    end
  end
end
