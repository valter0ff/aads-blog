# frozen_string_literal: true

# == Schema Information
#
# Table name: subscriptions
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  subscribed_to_id :bigint           not null
#  subscriber_id    :bigint           not null
#
# Indexes
#
#  index_subscriptions_on_subscribed_to_id                    (subscribed_to_id)
#  index_subscriptions_on_subscriber_id                       (subscriber_id)
#  index_subscriptions_on_subscriber_id_and_subscribed_to_id  (subscriber_id,subscribed_to_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (subscribed_to_id => users.id)
#  fk_rails_...  (subscriber_id => users.id)
#
FactoryBot.define do
  factory :subscription do
    subscriber { association :user }
    subscribed_to { association :user }
  end
end
