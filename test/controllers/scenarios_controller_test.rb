require 'test_helper'

class ScenariosControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get scenarios_create_url
    assert_response :success
  end

end
