class EventPolicy < ApplicationPolicy
  def new?
    true
  end
  
  def update?
    record.gamer_id == @gamer.id
  end
  
  class Scope < Scope
    def resolve
      scope.where(gamer_id: @gamer.id)
    end
  end
end
