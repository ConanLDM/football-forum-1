class DiscussionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_discussion, only: [:show, :edit, :destroy, :update]

  def index
    @discussions = Discussion.all.order(updated_at: :desc)
  end

  def create
    @discussion = Discussion.new(discussion_params)
    @discussion.user = Current.user

    respond_to do |format|
      if @discussion.save
        format.html { redirect_to @discussion, notice: "A Discussion has been created" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def new
    @discussion = Discussion.new
    @discussion.posts.new
  end

  def edit

  end

  def update
    respond_to do |format|
      if @discussion.update(discussion_params)
        @discussion.broadcast_replace(partial: "discussions/discussion_header", local: { discussion: @discussion })
        format.html { redirect_to @discussion, notice: "This discussion has been updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def show
    @posts = @discussion.posts.all.order(created_at: :asc)
    @new_post = @discussion.posts.new
  end

  def destroy
    @discussion.destroy!
    redirect_to discussions_path, notice: "This discussion has now been removed"
  end

  private

  def discussion_params
    params.require(:discussion).permit(:title, posts_attributes: :content)
  end

  def set_discussion
    @discussion = Discussion.find(params[:id])
  end
end
