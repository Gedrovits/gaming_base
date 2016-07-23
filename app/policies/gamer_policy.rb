class GamerPolicy < ApplicationPolicy
  def update?
    record.id == @gamer.id
  end
  
  class Scope < Scope
    def resolve
      scope
    end
  end
end
