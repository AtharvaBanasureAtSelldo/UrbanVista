require "jwt"

class SessionsController < ApplicationController
  skip_before_action :authorize_request
  skip_before_action :verify_authenticity_token, only: [ :create ]

  def new
  end

  # POST /login

  def create
    user=User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = encode_token({ user_id: user.id })
      cookies.signed[:jwt] = {
        value: token,
        httponly: true,
        expires: 24.hours.from_now
      }
      # render json: { message: "login Successful", token: token, user: user }, status: :ok
      redirect_to root_path
    else
      # render json: { errors: "Invalid Email or password" }, status: :unauthorized
      flash.now[:alert] = "Invalid email or password"
      redirect_to login_path, notice: "Invalid Email or Password"
    end
  end

  def destroy
    cookies.delete(:jwt)
    redirect_to login_path, notice: "Successfully logged out"
  end

  private
  def encode_token(payload)
    JWT.encode(payload, "my$ecretK3")
  end
end
