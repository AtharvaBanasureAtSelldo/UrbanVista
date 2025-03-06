require "jwt"

class SessionsController < ApplicationController
  skip_before_action :authorize_request
  skip_before_action :verify_authenticity_token, only: [ :create ]
  before_action :checkifuserloggedin, only: [ :new ]

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
      redirect_to root_path, notice: "Welcome back, #{user.name}!"
    else
      render :new, alert: "Invalid Email or Password", status: :unprocessable_entity
    end
  end

  def destroy
    cookies.delete(:jwt)
    redirect_to root_path, notice: "Successfully logged out"
  end

  private
  def encode_token(payload)
    JWT.encode(payload, "my$ecretK3")
  end
end
