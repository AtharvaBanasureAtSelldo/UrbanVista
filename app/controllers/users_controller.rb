require "jwt"
class UsersController < ApplicationController
  skip_before_action :authorize_request
  before_action :checkifuserloggedin, only: [ :new ]

  def new
    @user = User.new
    # authorize @user
  end

  # post /signup

  def create
    @user = User.new(user_params)
    # authorize @user
    if @user.save
      token = encode_token({ user_id: @user.id })
      # render json: { message: "User created Successfully", token: token, user: user }, status: :created
      cookies.signed[:jwt] = {
        value: token,
        httponly: true,
        expires: 24.hours.from_now
      }
      redirect_to login_path, notice: "User created Successfully"
    else
      flash.now[:alert] = "#{@user.errors.full_messages[0]}"
      render :new
    end
  end
  

  private

  def set_user
    @user = User.find(params[:id])
  end

  def encode_token(payload)
    JWT.encode(payload, "my$ecretK3")
  end

  def user_params
    # TODO :Remove tenant_id from all the forms etc.
    params.require(:user).permit(:name, :email, :role, :phone, :tenant_id, :password, :password_confirmation)
  end
end
