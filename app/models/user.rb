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
#  posts_count         :integer          default(0)
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

  has_many :posts, dependent: :destroy
  # Users that the current user is subscribed to
  has_many :subscriptions, foreign_key: :subscriber_id, dependent: :destroy, inverse_of: :subscriber
  has_many :subscribed_to_users, through: :subscriptions, source: :subscribed_to
  # Users that are subscribed to the current user
  has_many :subscribers_associations, foreign_key: :subscribed_to_id, class_name: 'Subscription', dependent: :destroy,
                                      inverse_of: :subscribed_to
  has_many :subscribers, through: :subscribers_associations, source: :subscriber
end
