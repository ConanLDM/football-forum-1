require "test_helper"

class DiscussionTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    Current.user = @user
  end

  test "belongs to a user" do
    discussion = Discussion.new(user: @user)
    assert_equal @user, discussion.user
  end

  test "can be created with current user" do
    discussion = Discussion.create
    assert_equal Current.user, discussion.user
  end
end
