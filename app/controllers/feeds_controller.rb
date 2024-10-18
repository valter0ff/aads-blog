# frozen_string_literal: true

class FeedsController < ProtectedController
  def index
    posts = current_user.subscribed_to_posts.lazy_preload(:user).order(created_at: :desc)
    @pagy, posts = pagy(posts, items: Constants::Shared::ITEMS_PER_PAGE)
    @posts = posts.decorate
  end
end
