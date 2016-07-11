require 'rails_helper'

RSpec.describe Gamer, type: :model do
  subject { build(:gamer) }
  
  include_examples 'privacy_support'
  
  describe 'have valid factory' do
    it { is_expected.to be_valid }
  end
  
  context 'have all enums' do
    it { is_expected.to define_enum_for(:sex) }
    it { is_expected.to define_enum_for(:dedication) }
    it { is_expected.to define_enum_for(:weekday_availability) }
    it { is_expected.to define_enum_for(:weekend_availability) }
    it { is_expected.to define_enum_for(:swearing) }
    it { is_expected.to define_enum_for(:swearing_tolerance) }
  end
  
  context 'have all relations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:memberships) }
    it { is_expected.to have_many(:communities).through(:memberships) }
    it { is_expected.to have_many(:teams).through(:memberships) }
    it { is_expected.to have_and_belong_to_many(:games) }
  end
  
  # Methods
  
  describe '#to_label' do
    it { expect(subject.to_label).to eq("#{subject.first_name} '#{subject.username}' #{subject.last_name}") }
  end
end
