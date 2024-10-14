# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserDecorator do
  let(:user) { build_stubbed(:user, first_name: 'John', last_name: 'Doe') }
  let(:decorated_user) { user.decorate }

  describe '#full_name' do
    it 'returns the full name of the post author' do
      expect(decorated_user.full_name).to eq('John Doe')
    end
  end
end
