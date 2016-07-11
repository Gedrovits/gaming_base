class Community < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  
  include PrivacySupport
  
  # Relations
  has_many :memberships, inverse_of: :community
  has_many :gamers, through: :memberships
  has_many :teams, through: :memberships
  has_and_belongs_to_many :games
  
  # Validations
  validates :name, presence: true
  # validates :privacy, presence: true
  
  def slug_candidates
    [:name] + Array.new(6) { |index| [:name, index + 2] }
  end
  
  def to_label
    name
  end
end
