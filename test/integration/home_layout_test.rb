require 'test_helper'

class HomeLayoutTest < ActionDispatch::IntegrationTest

  test "mainpage links" do
  	get root_path
  	assert_template 'static_pages/home'
  	assert_select "a[href=?]", login_path
	end

	test "displayed login page" do
		get login_path
		assert_template 'sessions/new'
	end

  test "displayed registration form" do
  	get signup_path
  	assert_template 'users/new'
  end

end
