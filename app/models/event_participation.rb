class EventParticipation < ApplicationRecord
  enum status: [:pending, :accepted, :tentative, :declined] # tentative / decline with a reason?
  
  # Relations
  belongs_to :event
  belongs_to :gamer
end
