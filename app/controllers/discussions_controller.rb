class DiscussionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @discussions = Discussion.all
  end

  def create
    @discussion = Discussion.new(discussion_params)
    @discussion.user = Current.user

    respond_to do |format|
      if @discussion.save
        format.html { redirect_to discussions_path, notice: "A Discussion has been created" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def new
    @discussion = Discussion.new
  end

  private

  def discussion_params
    params.require(:discussion).permit(:title)
  end
end
