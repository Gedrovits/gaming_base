require 'rails_helper'

RSpec.describe Role, type: :model do
  subject { build(:role) }
  
  describe 'have valid factory' do
    it { is_expected.to be_valid }
  end
  
  context 'have all relations' do
    it { is_expected.to have_many(:memberships) }
  end
  
  # Attributes
  
  describe '#name' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
  
  # Methods
  
  describe '#to_label' do
    it { expect(subject.to_label).to eq(subject.name) }
  end
end
