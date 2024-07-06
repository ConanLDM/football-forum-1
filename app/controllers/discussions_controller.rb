class DiscussionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @discussions = Discussion.all
  end

  def create
    @discussion = Discussion.new(discussion_params)
    @discussion.user = Current.user

    if @discussion.save
      flash[:notice] = "Discussion created successfully!"
      redirect_to @discussion
    else
      render :new
    end
  end

  def new
    @discussion = Discussion.new
  end
end
