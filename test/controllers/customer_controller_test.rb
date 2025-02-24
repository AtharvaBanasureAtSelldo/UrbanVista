require "test_helper"

class CustomerControllerTest < ActionDispatch::IntegrationTest
  test "should get tenant:" do
    get customer_tenant: _url
    assert_response :success
  end

  test "should get references" do
    get customer_references_url
    assert_response :success
  end
end
