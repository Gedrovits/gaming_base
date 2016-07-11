require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }
  
  describe 'have valid factory' do
    it { is_expected.to be_valid }
  end
  
  context 'have all relations' do
    it { is_expected.to have_one(:gamer) }
    it { is_expected.to have_many(:identities) }
    it { is_expected.to have_many(:memberships).through(:gamer) }
    it { is_expected.to have_many(:communities).through(:gamer) }
    it { is_expected.to have_many(:teams).through(:gamer) }
    it { is_expected.to have_many(:games).through(:gamer) }
  end
  
  # Methods
  
  describe '#to_label' do
    it { expect(subject.to_label).to eq(subject.email) }
  end
end
