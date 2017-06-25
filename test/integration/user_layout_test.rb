require 'test_helper'

class UserLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:test)
  end

  test "clicked Spotrebice link" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'Dominecko1234' } }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    get user_appliances_path(@user.id)
    assert_template 'appliances/index'
    assert_select "div[id=?]", "table_entries"
    assert_select "div[id=?]", "sidebar"
  end

  test "clicked vytvor button" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'Dominecko1234' } }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    get new_user_scenario_path(@user.id)
    assert_template 'scenarios/new'
  end

end
