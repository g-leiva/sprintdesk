require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get signup page" do
    get signup_path
    assert_response :success
  end

  test "should create user with valid params" do
    assert_difference("User.count", 1) do
      post signup_path, params: {
        user: {
          name: "Nuevo Usuario",
          email: "nuevousuario@test.com",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end
    assert_redirected_to root_path
  end

  test "should not create user with invalid parameters" do
    assert_no_difference("User.count") do
      post signup_path, params: {
        user: {
          name: "",
          email: "invalid",
          password: "123",
          password_confirmation: "456"
        }
      }
    end
    assert_response :unprocessable_entity
  end
end
