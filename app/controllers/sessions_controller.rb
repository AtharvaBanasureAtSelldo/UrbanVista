require "jwt"

class SessionsController < ApplicationController
  skip_before_action :authorize_request, only: [:create]
  skip_before_action :verify_authenticity_token, only: [ :create ]

  #POST /login

  def create
    binding.pry
    user=User.find_by(email: params[:email])
    binding.pry
    if user&.authenticate(params[:password])
      token = encode_token({ user_id: user.id })
      render json: { message: "login Successful", token: token, user: user }, status: :ok
    else
      render json: { errors: "Invalid Email or password" }, status: :unauthorized
    end
  end


  private
  def encode_token(payload)
    JWT.encode(payload, JWT_SECRET)
  end
end
