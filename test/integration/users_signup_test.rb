require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
  	get signup_path
  	assert_no_difference 'User.count' do
  		post users_path, params: { user: {
  				email: "asfascfhakj@sdfkjvhk.com",
  				address: "",
  				password: "foobaristic",
  				password_confirmation: "kookaristic"
  			}}
  	end
  	assert_template 'users/new'
  	assert_select "div#error_explanation", count: 1
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 0 do
      post signup_path, params: { user: { name:  "Example Use",
                                         email: "user@exampe.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end
end
