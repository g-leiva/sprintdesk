require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get login page" do
    get login_path
    assert_response :success
  end

  test "should login with valid credentials" do
    user = users(:gerber)
    post login_path, params: { email: user.email, password: "password123" }
    assert_redirected_to root_path
  end

  test "should not login with invalid credentials" do
    post login_path, params: { email: "wrongemail@gmail.com", password: "wrong" }
    assert_response :unprocessable_entity
  end

  test "should logout" do
    user = users(:gerber)
    post login_path, params: { email: user.email, password: "password123" }
    delete logout_path
    assert_redirected_to login_path
  end
end
