# frozen_string_literal: true

class PostDecorator < Draper::Decorator
  delegate_all
  decorates_association :user

  def author
    user.full_name
  end
end
