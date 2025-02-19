class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authorize_request

  def decode_token
    auth_header = request.headers["Authorization"]

    if auth_header
      token = auth_header.split(" ").last
      begin
        JWT.decode(token, JWT_SECRET, true, algorithm: "HS256")
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


  # Restrict access to authorized users only
  def authorize_request
    render json: { errors: "Unauthorized" }, status: :unauthorized unless current_user
  end
end
