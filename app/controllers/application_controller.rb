class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  add_flash_types :danger, :info, :warning, :success, :messages
  protect_from_forgery with: :null_session
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authorize_request

  helper_method :current_user

  def checkifuserloggedin
    if current_user
      redirect_to root_path, alert: "You are already logged in."
    end
  end

  def decode_token
    auth_header = cookies.signed[:jwt]
    if auth_header
      token = auth_header
      begin
        JWT.decode(token, "my$ecretK3", true, algorithm: "HS256")
      rescue JWT::DecodeError
        nil
      end
    end
  end


  # Fetch the current user from the token
  def current_user
    decoded_token = decode_token
    if decoded_token
      user_id = decoded_token[0]["user_id"]
      @current_user ||= User.find_by(id: user_id)
    end
  end

  def not_found
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  # Restrict access to authorized users only
  def authorize_request
    unless current_user
      flash[:alert] = "Your session has expired. Please log in again."
      redirect_to login_path
    end
  end

  private
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to root_path
  end
end
