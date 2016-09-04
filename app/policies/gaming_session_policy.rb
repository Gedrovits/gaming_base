class GamingSessionPolicy < ApplicationPolicy
  def update?
    true # FIXME
    # membership&.role_id == Role.leader.id
  end
  
  def destroy?
    true # FIXME
    # membership&.role_id == Role.leader.id
  end
  
  class Scope < Scope
    def resolve
      scope
    end
  end
end
