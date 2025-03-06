class UserPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  def index?
    user.present? && user.is_admin?
  end

  def new?
    user.present? && user.is_admin?
  end

  def create?
    user.present? && user.is_admin?
  end

  def show?
    user.present? && user.is_admin?
  end

  def edit?
    user.present? && user.is_admin?
  end

  def update?
    user.present? && user.is_admin?
  end

  def destroy?
    user.present? && user.is_admin?
  end

  def createAgent?
    user.present? && user.is_admin?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.is_admin?
        scope.where(tenant_id: user.tenant_id) 
      else
        scope.where(role: "agent")
      end
    end
  end
end
