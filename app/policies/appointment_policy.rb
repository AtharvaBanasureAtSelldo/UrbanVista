class AppointmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.is_admin?
        scope.where(tenant_id: user.tenant_id) 
      else
        scope.where(user_id: user.id).or(scope.where(customer_id: user.id))
      end
    end
  end

  def index?
    user.present?
  end

  def show?
    user.is_admin? || record.user_id == user.id || record.customer_id == user.id
  end

  def create?
    user.is_admin? || user.is_agent?
  end

  def update?
    user.is_admin? || record.user_id == user.id
  end

  def destroy?
    user.is_admin?
  end
end