# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                  :bigint           not null, primary key
#  email               :string           default(""), not null
#  encrypted_password  :string           default(""), not null
#  first_name          :string           default(""), not null
#  last_name           :string           default(""), not null
#  remember_created_at :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  devise :database_authenticatable, :registerable

  validates :email, presence: { on: :create },
                    format: { with: Constants::User::EMAIL_REGEXP },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: { on: :create },
                       confirmation: { on: :create },
                       length: { minimum: Constants::User::PASSWORD_MIN_SIZE,
                                 maximum: Constants::User::PASSWORD_MAX_SIZE },
                       format: { with: Constants::User::PASSWORD_REGEXP }
  validates :first_name, presence: true
  validates :last_name, presence: true
end
