require 'test_helper'

class UserAppliancesTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:test)
  end

  test "trying to add valid spotrebic" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'Dominecko1234' } }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    get user_appliances_path(@user.id)
    assert_template 'appliances/index'
    assert_difference 'EntryRoom.count', 1 do
      post user_appliances_path(@user.id), xhr: true, params: { appliance: {
                                                                  name: 'Chladnička',
                                                                },
                                                                room: 'Obývačka',
                                                                count: 1,
                                                                performance: 1000
      }
    end
  end

end