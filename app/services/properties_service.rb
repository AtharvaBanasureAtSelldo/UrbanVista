class PropertiesService
  def initialize(params)
    @title = params[:title],
    @address = params[:address],
    @price = params[:price],
    @tenant_id = params[:tenant_id],
    @user_id = params[:user_id]
  end

  def self.fetch_property(id)
    Property.find(id)
  rescue ActiveRecord::RecordNotFound
    raise ActiveRecord::RecordNotFound, "property not found"
  end

  def self.list_all_properties(user = nil)
    if user&.role == "admin"
      Property.order(created_at: :desc)
    else
      Property.where(user_id: user.id).order(created_at: :desc)
    end
  end

  def self.property_statistics
    {
      property_count: Property.count,
      agent_count: User.where(role: "agent").count
    }
  end
end