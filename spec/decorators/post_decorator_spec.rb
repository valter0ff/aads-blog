# frozen_string_literal: true

RSpec.describe PostDecorator do
  let(:user) { build_stubbed(:user, first_name: 'John', last_name: 'Doe') }
  let(:post) { build_stubbed(:post, user: user) }
  let(:decorated_post) { post.decorate }

  describe '#author' do
    it 'returns the full name of the post author' do
      expect(decorated_post.author).to eq('John Doe')
    end
  end
end
