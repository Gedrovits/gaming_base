require 'rails_helper'

RSpec.describe Game, type: :model do
  subject { build(:game) }
  
  describe 'have valid factory' do
    it { is_expected.to be_valid }
  end
  
  describe 'have all relations' do
    it { is_expected.to have_and_belong_to_many(:communities) }
    it { is_expected.to have_and_belong_to_many(:teams) }
    it { is_expected.to have_and_belong_to_many(:gamers) }
  end
  
  describe '#name' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
