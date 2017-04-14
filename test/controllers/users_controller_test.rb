require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  test "should get registration form" do
   	get signup_url
  	assert_response :success
  	assert_select "title", "Sign up"
  end


  #test "should get new" do
  #  get users_new_url
  #  assert_response :success
  #end
end