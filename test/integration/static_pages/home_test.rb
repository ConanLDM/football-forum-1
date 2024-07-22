require 'test_helper'

class StaticPagesTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "div", "Football forum... redefined..."
    assert_select "a[href=?]", discussions_path, "Active Discussions"
  end
end
