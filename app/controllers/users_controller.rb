require "jwt"
class UsersController < ApplicationController
  skip_before_action :authorize_request, only: [ :create ]  # from Application Controller

  #post /signup

  def create
    user = User.new(user_params)
    if user.save
      token = encode_token({ user_id: user.id })
      render json: { message: "User created Successfully", token: token, user: user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end


  private

  def encode_token(payload)
    JWT.encode(payload, JWT_SECRET)
  end

  def user_params
    params.require(:user).permit(:name, :email, :role, :phone, :tenant_id, :password, :password_confirmation)
  end
end
