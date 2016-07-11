RSpec.shared_examples 'privacy_support' do
  describe 'defines privacy enum' do
    it { expect(described_class.privacies).to be_an(Hash) }
  end
end
