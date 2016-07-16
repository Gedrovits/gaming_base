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
  
  def self.founder
    find_by(abbreviation: 'FNDR')
  end
  
  def self.leader
    find_by(abbreviation: 'LDR')
  end
  
  def self.second_in_command
    find_by(abbreviation: '2IC')
  end
  
  def self.manager
    find_by(abbreviation: 'MNGR')
  end
  
  def self.member
    find_by(abbreviation: 'MMBR')
  end
  
  def self.newbie
    find_by(abbreviation: 'NWB')
  end
  
  def self.friend
    find_by(abbreviation: 'FRND')
  end
end
