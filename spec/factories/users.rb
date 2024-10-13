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
FactoryBot.define do
  factory :user do
    email { FFaker::Internet.unique.email }
    password { "#{FFaker::Internet.password.truncate(10)}aA1" }
    password_confirmation { password }
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
  end
end
