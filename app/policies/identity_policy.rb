class IdentityPolicy < ApplicationPolicy
  def show?
    user.id == record.id
  end
  
  def update?
    user.id == record.id
  end
  
  class Scope < Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end
end
