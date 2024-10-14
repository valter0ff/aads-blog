# frozen_string_literal: true

class ProtectedController < ApplicationController
  before_action :authenticate_user!
end
