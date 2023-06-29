module Api
  module V1
    class PostsController < ApplicationController
      def index
        user = User.find(params[:user_id])
        posts = user.posts

        render json: posts
      end

      def show
        post = Post.find(params[:id])

        render json: post
      end
    end
  end
end
