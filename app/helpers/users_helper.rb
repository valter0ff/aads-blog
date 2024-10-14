# frozen_string_literal: true

module UsersHelper
  def subscribed_to?(user)
    current_user.subscribed_to_users.include?(user)
  end
end
