class Game < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  acts_as_paranoid
  
  # Relations
  has_and_belongs_to_many :communities
  has_and_belongs_to_many :teams
  has_and_belongs_to_many :gamers
  
  has_many :event_games, inverse_of: :game
  has_many :events, through: :event_games
  
  # Validations
  validates :name, presence: true
  
  def slug_candidates
    [:name] + Array.new(6) { |index| [:name, index + 2] }
  end
  
  def to_label
    name
  end
end
