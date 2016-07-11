require 'rails_helper'

RSpec.describe Team, type: :model do
  subject { build(:team) }
  
  describe 'have valid factory' do
    it { is_expected.to be_valid }
  end
  
  include_examples 'privacy_support'
  
  describe 'have all relations' do
    it { is_expected.to have_many(:memberships) }
    it { is_expected.to have_many(:gamers).through(:memberships) }
    it { is_expected.to have_many(:communities).through(:memberships) }
    it { is_expected.to have_and_belong_to_many(:games) }
  end
  
  describe '#to_label' do
    it { expect(subject.to_label).to eq(subject.name) }
  end
end
