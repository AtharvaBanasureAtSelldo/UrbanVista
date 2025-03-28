class AgentsController < ApplicationController
  before_action :set_layout

  def index
    @agents = policy_scope(User).where(role: "agent")
    authorize :agent, :index?
    render layout: @layout
  end

  def new
    render layout: @layout
  end

  def create
  end

  private
  def set_layout
    @layout = current_user.role == "admin" ? "admin" : "agent"
  end

  def agent_params
    
  end
end
