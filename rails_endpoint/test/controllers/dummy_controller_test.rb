require 'test_helper'

class DummyControllerTest < ActionDispatch::IntegrationTest
  test "should get upload" do
    get dummy_upload_url
    assert_response :success
  end

end
