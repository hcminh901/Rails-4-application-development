require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get home_page" do
    get :home_page
    assert_response :success
  end

end
