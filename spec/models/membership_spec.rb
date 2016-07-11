require 'rails_helper'

RSpec.describe Membership, type: :model do
  subject { build(:membership) }
  
  it 'have overridden inheritance_column' do
    expect(described_class.inheritance_column).to eq("x")
  end
  
  include_examples 'privacy_support'
  
  context 'have all enums' do
    it { is_expected.to define_enum_for(:status) }
    it { is_expected.to define_enum_for(:type) }
  end
  
  context 'have all relations' do
    it { is_expected.to belong_to(:community) }
    it { is_expected.to belong_to(:team) }
    it { is_expected.to belong_to(:gamer) }
    it { is_expected.to belong_to(:role) }
  end
  
  # Methods
  
  describe '.privacy_filter' do
    context 'without gamer_id' do
      pending
    end
    
    context 'without team_ids' do
      pending
    end
    
    context 'without community_ids' do
      pending
    end
  end
end
