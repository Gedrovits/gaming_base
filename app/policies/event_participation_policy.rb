class EventParticipationPolicy < ApplicationPolicy
  def update?
    record.gamer_id == @gamer.id
  end
  
  class Scope < Scope
    def resolve
      scope
    end
  end
end
