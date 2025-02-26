class PagesController < ApplicationController
  def defaultpage
    if current_user
      render layout: current_user.role == "admin" ? "admin" : "agent"
    end
  end
end
