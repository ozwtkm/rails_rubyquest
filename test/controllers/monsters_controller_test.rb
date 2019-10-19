require 'test_helper'

class MonstersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get monsters_index_url
    assert_response :success
  end

end
