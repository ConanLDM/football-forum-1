module Discussions
  class PostsController < ApplicationController
    include Pagy::Backend
    before_action :authenticate_user!
    before_action :set_discussion
    before_action :set_post, only: [:show, :edit, :update, :destroy]


    def show

    end

    def edit

    end


    def update
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to @post.discussion, notice: "Post updated" }
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    def create
      @post = @discussion.posts.new(post_params)

      respond_to do |format|
        if @post.save
          send_post_notification!(@post)

          @pagy, @posts = pagy(@discussion.posts.order(created_at: :desc), items: 5)
          format.html { redirect_to discussion_path(@discussion, page: @pagy.last), notice: "Post created" }
          format.turbo_stream
        else
          format.turbo_stream
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @post.destroy

      respond_to do |format|
        format.turbo_stream { }
        format.html { redirect_to @post.discussion, notice: "Post has been deleted" }
      end
    end

    private

    def send_post_notification!(post)
      post_subscribers = post.discussion.subscribed_users - [post.user]
      NewPostNotification.with(post: post).deliver_later(post_subscribers)
    end

    def set_discussion
      @discussion = Discussion.find(params[:discussion_id])
    end

    def set_post
      @post = @discussion.posts.find(params[:id])
    end


    def post_params
      params.require(:post).permit(:content)
    end
  end
end
