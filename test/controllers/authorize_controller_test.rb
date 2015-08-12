require 'test_helper'

class AuthorizeControllerTest < ActionController::TestCase
  test "should get linkedin" do
    get :linkedin
    assert_response :success
  end

  test "should get facebook" do
    get :facebook
    assert_response :success
  end

  test "should get twitter" do
    get :twitter
    assert_response :success
  end

end
