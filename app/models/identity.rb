class Identity < ApplicationRecord
  acts_as_paranoid
  
  # Relations
  belongs_to :user
  
  # Validations
  validates :uid,      presence: true, uniqueness: { scope: :provider }
  validates :provider, presence: true
  
  # Methods
  
  def self.find_for_oauth(auth)
    find_or_create_by(uid: auth.uid, provider: auth.provider)
  end
end
