# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET /users' do
    context 'with a valid user type' do
      it 'returns a successful response for subscribed_to_users' do
        get authors_path(type: :subscribed_to_users)
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:index)
      end

      it 'returns a successful response for all_authors' do
        get authors_path(type: :all_authors)
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:index)
      end
    end

    context 'with an invalid user type' do
      it 'raises a StandardError and returns a 500 status' do
        expect { get authors_path(type: :invalid_type) }
          .to raise_error(StandardError, I18n.t('subscriptions.smth_went_wrong'))
      end
    end
  end

  it_behaves_like 'not authenticated user'
end
