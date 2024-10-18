# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Subscriptions', type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  before { sign_in user }

  describe 'POST /subscriptions' do
    before do |example|
      unless example.metadata[:skip_before]
        post subscriptions_path, params: { id: }, headers: { HTTP_REFERER: root_path }
      end
    end

    context 'when subscribing to another user' do
      let(:id) { other_user.id }

      it 'creates a subscription and redirects back with a success notice' do
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(flash[:notice]).to eq(I18n.t('subscriptions.subscribed', user_name: other_user.decorate.full_name))
        expect(user.subscribed_to_users).to include(other_user)
      end
    end

    context 'when trying to subscribe to oneself' do
      let(:id) { user.id }

      it 'does not create a subscription and redirects back with an alert' do
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(flash[:alert]).to eq(I18n.t('subscriptions.self_subscription_error'))
        expect(user.subscribed_to_users).not_to include(user)
      end
    end

    context 'when trying to subscribe to a non-existing user' do
      let(:id) { -1 }

      it 'redirects back with an alert that the user was not found' do
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(flash[:alert]).to eq(I18n.t('subscriptions.author_not_found'))
      end
    end

    context 'when already subscribed to the user' do
      let(:make_request) do
        post subscriptions_path, params: { id: other_user.id }, headers: { HTTP_REFERER: root_path }
      end

      it 'does not create another subscription and redirects back with an alert', :skip_before do
        user.subscribed_to_users << other_user
        make_request

        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(flash[:alert]).to eq(I18n.t('subscriptions.already_subscribed'))
      end
    end
  end

  describe 'DELETE /subscriptions' do
    context 'when unsubscribing from a user' do
      before do
        user.subscribed_to_users << other_user
        delete subscription_path(other_user), headers: { HTTP_REFERER: root_path }
      end

      it 'deletes the subscription and redirects back with a success notice' do
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(flash[:notice]).to eq(I18n.t('subscriptions.unsubscribed', user_name: other_user.decorate.full_name))
        expect(user.subscribed_to_users).not_to include(other_user)
      end
    end

    context 'when trying to unsubscribe from a user not subscribed to' do
      before { delete subscription_path(other_user), headers: { HTTP_REFERER: root_path } }

      it 'does not remove a subscription and redirects back with an alert' do
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(flash[:alert]).to eq(I18n.t('subscriptions.not_subscribed'))
      end
    end

    context 'when trying to unsubscribe from a non-existing user' do
      before { delete subscription_path(id: -1), headers: { HTTP_REFERER: root_path } }

      it 'redirects back with an alert that the user was not found' do
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(flash[:alert]).to eq(I18n.t('subscriptions.author_not_found'))
      end
    end
  end
end
