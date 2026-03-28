require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should redirect to login when not authenticated" do
    get root_path
    assert_redirected_to login_path
  end

  test "should get dashboard when authenticated" do
    user = users(:gerber)
    post login_path, params: { email: user.email, password: "password123" }
    get root_path
    assert_response :success
  end
end
