# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Feeds', type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:subscribed_post) { create(:post, user: other_user) }

  before do
    sign_in user
    user.subscriptions.create(subscribed_to: other_user)
  end

  describe 'GET /feeds' do
    context 'when user is signed in' do
      before { get feeds_path }

      it 'returns a successful response with index template' do
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:index)
      end

      it 'loads posts from subscribed users' do
        expect(assigns(:posts)).to include(subscribed_post.decorate)
      end
    end

    context 'with a lot amount of posts' do
      before do
        create_list(:post, 20, user: other_user)
        get feeds_path
      end

      it 'paginates posts with pagy' do
        expect(assigns(:pagy)).to be_present
        expect(assigns(:posts).size).to eq(Constants::Shared::ITEMS_PER_PAGE)
      end
    end

    it_behaves_like 'not authenticated user'
  end
end
