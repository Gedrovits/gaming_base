class UserPolicy < ApplicationPolicy
  def show?
    user.id == record.id
  end
  
  def update?
    user.id == record.id
  end
  
  def become_user?
    user.is_core?
  end
  
  class Scope < Scope
    def resolve
      scope
    end
  end
end
