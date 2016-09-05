class Event < ApplicationRecord
  self.inheritance_column = :x

  include PrivacySupport

  enum type: [:gaming_session, :meeting, :mixed]
  enum status: [:draft, :pending, :cancelled, :in_progress, :finished, :archived] # rescheduled?
  
  # Relations
  belongs_to :gamer
  has_many :event_games, inverse_of: :event
  has_many :games, through: :event_games
  has_many :event_participation, inverse_of: :event
  has_many :gamers, through: :event_participation
  
  # Callbacks
  accepts_nested_attributes_for :event_games, reject_if: :all_blank
  accepts_nested_attributes_for :event_participation, reject_if: :all_blank
  
  # Validations
  validates :starts_at, presence: true
  validates :ends_at, presence: true
  
  # Additional information...
  # organizer / host (gamer_id)
  # starts_at / ends_at (datetimes)
  # duration manually? (in hours)
  # Recurrence...
  
  # Participation (Respond with comments / no comments)
  # Response / Status: Accept / Tentative / Decline / Propose new time (tentative / decline)
  # reminder before event...
  
  # Calendar: (Today / Day / Week / Month / Year)
end
