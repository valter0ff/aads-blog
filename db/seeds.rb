# frozen_string_literal: true

include FactoryBot::Syntax::Methods

25.times do
  user = create(:user)
  25.times do
    create(:post, user: user)
  end
end
