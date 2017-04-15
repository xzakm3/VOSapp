require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
  	@user = User.new(email: "jozko.madarkvcka@gmal.com", address: "Dobrovic 2", password: "foobaricek", password_confirmation: "foobaricek")
  end

  test "user should be valid" do
  	assert @user.valid?
  end

  test "user email should be presence" do
  	@user.email = "    "
  	assert_not @user.valid?
  end

  test "user address should be presence" do
  	@user.address = "      "
  	assert_not @user.valid?
  end

  test "user address should not be too long" do
  	@user.address = 'a'*51
  	assert_not @user.valid?
  end

  test "user email should not be too long" do
  	@user.email = 'a'*244 + "example.com"
  	assert_not @user.valid?
  end

  test "email validation should accept valid email addresses" do
  	addresses = %w[USER@foo.COM THE_US-ER@foo.bar.org first.last@foo.jp]
  	addresses.each do |address|
  		@user.email = address
  		assert @user.valid?, "#{address.inspect} is valid"
  	end
  end

  test "email validation should reject invalid email addresses" do
  	addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    addresses.each do |invalid_address|
    	@user.email = invalid_address
    	assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
=begin
  test "email and address should be unique" do
  	duplicate_user = @user.dup
  	@user.save
  	assert_not duplicate_user.valid?, "#{@user.email} or #{@user.address} has already been taken"
  end

  test "email addresses should be saved as lower-case" do
  	mixed_case_email = "fOobAr@GmaIl.cOm"
  	@user.email = mixed_case_email
  	@user.save
  	assert_equal mixed_case_email.downcase, @user.reload.email
  end
=end
  
  test "password should not be blank" do
  	@user.password = @user.password_confirmation = " " * 10
  	assert_not @user.valid?
  end

  test "password should not be too long" do
  	@user.password = @user.password_confirmation = 'a' * 7
  	assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    @user.authenticated?('')
  end
end
