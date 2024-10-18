# frozen_string_literal: true

RSpec.shared_examples 'not authenticated user' do
  before { sign_out user }

  it 'redirects to the sign-in page' do
    get feeds_path
    expect(response).to redirect_to(new_user_session_path)
  end
end
