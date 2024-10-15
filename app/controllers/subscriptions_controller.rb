# frozen_string_literal: true

class SubscriptionsController < ProtectedController
  before_action :find_user, only: %i[create destroy]

  def index # rubocop:disable Metrics/MethodLength
    users = case params[:type].to_sym
            when :subscribed_to then subscribed_to_users
            when :subscribers then subscribers
            end

    if users.nil?
      flash[:alert] = t('subscriptions.smth_went_wrong')
      render 'homepage/index', status: :unprocessable_entity
    else
      @pagy, users = pagy(users, items: Constants::Shared::ITEMS_PER_PAGE)
      @users = users.decorate
      render 'users/index', locals: { users_type: params[:type] }
    end
  end

  def create
    if cant_proceed_subscription?
      redirect_to request.referer, alert: @alert_message, status: :see_other
      return
    end

    subscribed_to_users << @user
    redirect_to request.referer, notice: t('subscriptions.subscribed', user_name: @user.decorate.full_name)
  end

  def destroy
    unless subscribed_to_users.include?(@user)
      redirect_to request.referer, alert: t('subscriptions.not_subscribed'), status: :see_other
      return
    end

    subscribed_to_users.delete(@user)
    redirect_to request.referer, notice: t('subscriptions.unsubscribed', user_name: @user.decorate.full_name)
  end

  private

  def find_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to request.referer, alert: t('subscriptions.author_not_found')
  end

  def cant_proceed_subscription?
    @alert_message = if @user == current_user
                       t('subscriptions.self_subscription_error')
                     elsif subscribed_to_users.include?(@user)
                       t('subscriptions.already_subscribed')
                     end

    @alert_message.present?
  end

  delegate :subscribed_to_users, :subscribers, to: :current_user
end
