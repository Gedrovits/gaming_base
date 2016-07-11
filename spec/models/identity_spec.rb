require 'rails_helper'

RSpec.describe Identity, type: :model do
  subject { build(:identity) }
  
  describe 'have valid factory' do
    it { is_expected.to be_valid }
  end
  
  describe 'have all relations' do
    it { is_expected.to belong_to(:user) }
  end
  
  # Attributes
  
  # describe '#uid' do
  #   it { is_expected.to validate_presence_of(:uid) }
  #   it { is_expected.to validate_uniqueness_of(:uid).scoped_to(:provider) }
  # end
  
  describe '#provider' do
    it { is_expected.to validate_presence_of(:provider) }
  end
  
  # Methods
  
  describe '.find_for_oauth' do
    pending
  end
end
