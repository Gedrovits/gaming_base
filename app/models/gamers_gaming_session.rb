class GamersGamingSession < ApplicationRecord
  belongs_to :gaming_session
  belongs_to :gamer
  
  enum status: [:pending, :accepted, :declined]
end

