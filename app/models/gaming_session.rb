class GamingSession < ApplicationRecord
  self.inheritance_column = :x
  
  include PrivacySupport
  
  enum type: [:default]
  enum status: [:draft, :pending, :in_progress, :finished, :archived]

  has_and_belongs_to_many :games
  has_many :gamers_gaming_sessions
  has_and_belongs_to_many :gamers
end
