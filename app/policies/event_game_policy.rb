class EventGamePolicy < ApplicationPolicy
  def update?
    record.event.gamer_id == @gamer.id
  end
  
  class Scope < Scope
    def resolve
      scope
    end
  end
end
