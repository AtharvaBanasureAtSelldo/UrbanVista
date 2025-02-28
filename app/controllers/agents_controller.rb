class AgentsController < ApplicationController
  before_action :set_layout

  def index
    @agents = policy_scope(User).where(role: "agent")
    authorize :agent, :index?
    render layout: @layout
  end

  def new
    @agent = User.where(role: "agent")
    render layout: @layout
  end

  private
  def set_layout
    @layout = current_user.role == "admin" ? "admin" : "agent"
  end
end
