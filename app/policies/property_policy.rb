class PropertyPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5
  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
    def resolve
      return scope.none unless user.present?

      if user.present? && user.is_admin?
        scope.all # Admins can see all customers
      else
        scope.where(user_id: user.id) # Agents can only see their customers
      end
    end
  end


  def index?
    true
  end

  def show?
    user.present? && (user.is_admin? || record.user_id == user.id)
  end

  def create?
    user.present? && ( user.is_admin? || user.is_agent? )
  end

  def update?
    user.present? && (user.is_admin? || record.user_id == user.id)
  end

  def destroy?
    user.present? && (user.is_admin? || record.user_id == user.id)
  end
end
