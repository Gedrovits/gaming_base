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
end
