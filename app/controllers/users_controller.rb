class UsersController < ApplicationController
  skip_before_action :require_login, only: [ :new, :create ]
  def new
    redirect_to root_path if logged_in?
    @user = User.new
  end

  def create
    result = UserService.create(user_params)

    if result[:success]
      session[:user_id] = result[:user].id
      redirect_to root_path, notice: "Bienvenido, #{result[:user].name}!"
    else
      @user = User.new(user_params.except(:password, :password_confirmation))
      flash.now[:alert] = result[:errors].join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
