# frozen_string_literal: true

class UsersController < ProtectedController
  def index
    @pagy, users = pagy(filtered_users, items: Constants::Shared::ITEMS_PER_PAGE)
    @users = users.decorate
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def filtered_users
    params[:id].blank? ? User.all : User.where(id: params[:id])
  end
end
