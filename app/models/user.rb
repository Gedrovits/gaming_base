class User < ApplicationRecord
  include DeviseOmniauthSupport
  
  # Validations
  validates :email, format: { without: TEMP_EMAIL_REGEX }, on: :update
  
  # Relations
  has_one  :gamer
  has_many :identities
  
  has_many :memberships, through: :gamer
  has_many :communities, through: :gamer
  has_many :teams, through: :gamer
  has_many :games, through: :gamer
  
  # Methods
  
  def to_label
    email
  end
end
