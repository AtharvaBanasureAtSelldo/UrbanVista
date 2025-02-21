module ApplicationHelper
  def flash_class(level)
    case level.to_sym
    when :notice then "alert-success"  # Green for success
    when :alert then "alert-danger"   # Red for errors/alerts
    when :info then "alert-info"      # Blue for information
    when :warning then "alert-warning" # Yellow for warnings
    else "alert-secondary"            # Default gray
    end
  end
end
