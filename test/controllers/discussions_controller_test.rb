require 'test_helper'

class DiscussionsControllerTest < ActionDispatch::IntegrationTest
  test 'should redirect to login page when not logged in' do
    get discussions_path
    assert_redirected_to new_user_session_path
  end
end
