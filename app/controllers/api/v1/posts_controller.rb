module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, only: [:show, :update, :destroy]

      def index
        posts = Post.all
        # render json: @post
        render json: posts, each_serializer: PostSerializer
      end
      def show
        if @post
          render json: @post, serializer: PostSerializer
        else
          render json: {data: ""}
        end
      end
      def create
        puts post_params
        post = Post.new(post_params)
        if post.save
          render json: { status: 'SUCCESS', data: post }
        else
          render json: { status: 'ERROR', data:"" }
        end
      end
      def update
        if @post.update(post_params)
          render json: { status: 'SUCCESS', data: @post }
        else
          render json: { status: 'ERROR', data:"" }
        end
      end
      def destroy
        @post.destroy
        render json: { status: 'SUCCESS', message: 'Deleted the post', data: @post }
      end

      private
      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.permit(:content)
      end
    end
  end
end
