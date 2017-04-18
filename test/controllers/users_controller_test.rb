require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:test)
  end
  
  test "should get registration form" do
   	get signup_url
  	assert_response :success
  	assert_select "title", "Sign up"
  end


  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { email: @user.email,
                                              address: @user.address } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect index when not logged in" do
  	get users_path
  	assert_redirected_to login_path
  end
end