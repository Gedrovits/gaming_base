class Gamer < ApplicationRecord
  extend FriendlyId
  friendly_id :username, use: :slugged
  acts_as_paranoid
  
  include PrivacySupport
  
  enum sex: [:unknown, :female, :male]
  enum dedication: [:casual, :core, :hardcore, :pro]
  
  enum weekday_availability: [:none, :morning, :noon, :evening, :night, :always], _prefix: true
  enum weekend_availability: [:none, :morning, :noon, :evening, :night, :always], _prefix: true
  
  # TODO: Set the swearing default preference to "no preference"
  # TODO: For spoken_and_written should include spoken / writted guys too
  enum swearing: [:none, :spoken, :written, :spoken_and_written], _prefix: true
  enum swearing_tolerance: [:none, :spoken, :written, :spoken_and_written], _prefix: true
  
  # Relations
  belongs_to :user
  has_many :memberships, inverse_of: :gamer
  has_many :communities, through: :memberships
  has_many :teams, through: :memberships
  has_and_belongs_to_many :games
  has_many :language_proficiencies, inverse_of: :gamer
  has_and_belongs_to_many :gaming_sessions
  
  accepts_nested_attributes_for :language_proficiencies
  
  def slug_candidates
    [:username] + Array.new(6) { |index| [:username, index + 2] }
  end
  
  def to_label
    "#{first_name} '#{username}' #{last_name}"
  end
end
