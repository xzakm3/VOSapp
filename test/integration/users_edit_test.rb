require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
  	@user = users(:test)
  	@other = users(:testik)
  end

  test "unsuccessful edit" do
  	log_in_as(@user)
  	get edit_user_path(@user)
  	assert_template 'users/edit'
  	patch user_path(@user), params: { user: {
  				email: "",
  				address: "",
  				password: "foobaricek",
  				password_confirmation: "foobaricek"
  		} }
  	assert_template 'users/edit'
  end

  test "successful edit" do
  	#log_in_as(@user)
  	get edit_user_path(@user)
  	assert_template 'users/edit'
  	email = "martinko.martinko@martinko.martinko"
  	address = "martinko martinko"
  	patch user_path(@user), params: { user: {
  				email: email,
  				address: address,
  				password: "",
  				password_confirmation: ""
  		} }

  	assert_not flash.empty?
  	assert_redirected_to @user
  	@user.reload
  	assert_equal email, @user.email
  	assert_equal address, @user.address
  end

  test "successfull edit with friendly forwarding" do
  	get edit_user_path(@user)
  	log_in_as(@user)
  	assert_redirected_to edit_user_path(@user)
  	email = "testik2.testik2@testik2.testik2"
  	address = "testik2"
  	patch user_path(@user), params: { user: {
  							email: email,
  							address: address,
  							password: "",
  							password_confirmation: ""
  		} }
  	assert_not flash.empty?
  	assert_redirected_to @user
  	@user.reload
  	assert_equal email, @user.email
  	assert_equal address, @user.address
  end
end
