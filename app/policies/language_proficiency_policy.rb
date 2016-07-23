class LanguageProficiencyPolicy < ApplicationPolicy
  def create?
    record.gamer_id == @gamer.id
  end
  
  def update?
    record.gamer_id == @gamer.id
  end
  
  class Scope < Scope
    def resolve
      scope
    end
  end
end
