class TeamPolicy < ApplicationPolicy
  attr_accessor :membership
  
  def index?
    true
  end
  
  def update?
    membership&.role_id == Role.founder.id
  end
  
  def destroy?
    membership&.role_id == Role.founder.id
  end
  
  def join?
    membership.blank? || membership.declined? || membership.left?
  end
  
  def leave?
    membership && (membership.pending? || membership.approved?)
  end
  
  def manage_memberships?
    membership && membership.approved? && membership.role_id == Role.founder.id
  end
  
  private
  
  def membership
    @membership ||= @gamer.memberships.for_team(@record).first
  end
  
  class Scope < Scope
    def resolve
      scope
    end
  end
end
