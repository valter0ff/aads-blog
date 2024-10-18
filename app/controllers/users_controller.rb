# frozen_string_literal: true

class UsersController < ProtectedController
  ALLOWED_USER_TYPES = %i[subscribed_to_users subscribers all_authors].freeze

  def index
    users_type = params[:type].to_sym

    raise StandardError, t('subscriptions.smth_went_wrong') unless ALLOWED_USER_TYPES.include?(users_type)

    @pagy, users = pagy(select_users(users_type), items: Constants::Shared::ITEMS_PER_PAGE)
    @users = users.decorate
    render :index, locals: { users_type: }
  end

  private

  def select_users(users_type)
    case users_type
    when :all_authors then User.excluding(current_user)
    else current_user.public_send(users_type)
    end
  end
end
