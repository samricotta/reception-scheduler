require 'test_helper'

class ShiftsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get shifts_index_url
    assert_response :success
  end

  test "should get new" do
    get shifts_new_url
    assert_response :success
  end

end
