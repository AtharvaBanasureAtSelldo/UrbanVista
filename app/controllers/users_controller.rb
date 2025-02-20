require "jwt"
class UsersController < ApplicationController
  skip_before_action :authorize_request

  def new
    @user = User.new
  end

  # post /signup

  def create
    @user = User.new(user_params)

    if @user.save
      token = encode_token({ user_id: @user.id })
      # render json: { message: "User created Successfully", token: token, user: user }, status: :created
      cookies.signed[:jwt] = {
        value: token,
        httponly: true,
        expires: 24.hours.from_now
      }
      redirect_to login_path
    else
      # render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      render :new
    end
  end

  private

  def encode_token(payload)
    JWT.encode(payload, "my$ecretK3")
  end

  def user_params
    params.require(:user).permit(:name, :email, :role, :phone, :tenant_id, :password, :password_confirmation)
  end
end
