class SessionsController < ApplicationController
  skip_before_action :require_login, only: [ :new, :create ]
  def new
    redirect_to root_path if logged_in?
  end

  def create
    user = AuthenticationService.call(
      email: params[:email],
      password: params[:password]
    )

    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: "Bienvenido, #{user.name}!"
    else
      flash.now[:alert] = "Usuario o contraseña inválidos"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Sesión cerrada exitosamente"
  end
end
