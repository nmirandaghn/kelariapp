require 'test_helper'

class ProfileControllerTest < ActionDispatch::IntegrationTest
  test "should get name:string" do
    get profile_name:string_url
    assert_response :success
  end

  test "should get description:text" do
    get profile_description:text_url
    assert_response :success
  end

end
