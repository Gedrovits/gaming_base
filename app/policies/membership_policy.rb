class MembershipPolicy < ApplicationPolicy
  attr_accessor :membership
  
  def manage?
    @entity = @record.entity
    membership.role_id == Role.founder.id
  end
  
  def approve?
    manage?
  end
  
  def decline?
    manage?
  end
  
  def ban?
    manage?
  end
  
  def unban?
    manage?
  end
  
  def change_role?
    manage?
  end
  
  private
  
  def membership
    @membership ||= @gamer.memberships.for_entity(@entity).first
  end
  
  class Scope < Scope
    def resolve
      scope
    end
  end
end
