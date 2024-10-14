# frozen_string_literal: true

RSpec.describe FlashMessagesHelper, type: :helper do
  describe '#flash_class' do
    it 'returns the correct CSS class for a notice' do
      expect(helper.flash_class(:notice)).to eq('alert-info')
    end

    it 'returns the correct CSS class for a success message' do
      expect(helper.flash_class(:success)).to eq('alert-success')
    end

    it 'returns the correct CSS class for an error' do
      expect(helper.flash_class(:error)).to eq('alert-danger')
    end

    it 'returns the correct CSS class for an alert' do
      expect(helper.flash_class(:alert)).to eq('alert-danger')
    end

    it 'returns nil for an unknown message type' do
      expect(helper.flash_class(:unknown)).to be_nil
    end
  end
end
