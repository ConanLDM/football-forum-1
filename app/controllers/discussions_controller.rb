class DiscussionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_discussion, only: [:show, :edit, :destroy, :update]

  def index
    @pagy, @discussions = pagy(Discussion.includes(:category), items: 5)
  end

  def show
    @discussion = Discussion.find(params[:id])

    @pagy, @posts = pagy(@discussion.posts.includes(:user, :rich_text_content).order(created_at: :asc), items: 5)
    @new_post = @discussion.posts.new
  end

  def new
    @discussion = Discussion.new
    @discussion.posts.new
  end

  def create
    @discussion = Discussion.new(discussion_params)

    respond_to do |format|
      if @discussion.save
        format.html { redirect_to @discussion, notice: "A Discussion has been created" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit

  end

  def update
    respond_to do |format|
      if @discussion.update(discussion_params)
        DiscussionBroadcaster.new(@discussion).broadcast!
        format.html { redirect_to @discussion, notice: "This discussion has been updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @discussion.destroy!
    redirect_to discussions_path, notice: "This discussion has now been removed"
  end

  private

  def discussion_params
    params.require(:discussion).permit(:title, :category_id, :closed, posts_attributes: :content)
  end

  def set_discussion
    @discussion = Discussion.find(params[:id])
  end
end
