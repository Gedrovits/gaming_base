# This is the pre-defined set of roles which can be assigned on participation level
class Role < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  
  # Validations
  validates :name, uniqueness: true, presence: true
  
  has_many :memberships, inverse_of: :role
  
  def slug_candidates
    [:name] + Array.new(6) { |index| [:name, index + 2] }
  end
  
  def to_label
    name
  end
  
  # Shortcut methods to load specific roles
  
  def self.leader
    find_by(abbreviation: 'L')
  end
  
  def self.vice_leader
    find_by(abbreviation: 'VL')
  end
  
  def self.veteran_officer
    find_by(abbreviation: 'VO')
  end
  
  def self.officer
    find_by(abbreviation: 'O')
  end
  
  def self.veteran_member
    find_by(abbreviation: 'VM')
  end
  
  def self.member
    find_by(abbreviation: 'M')
  end
  
  def self.recruit
    find_by(abbreviation: 'R')
  end
  
  def self.friend
    find_by(abbreviation: 'F')
  end
end
