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
class Subscription < ApplicationRecord
  belongs_to :subscriber, class_name: 'User'
  belongs_to :subscribed_to, class_name: 'User'

  validates :subscriber_id,
            uniqueness: {
              scope: :subscribed_to_id,
              message: I18n.t('activerecord.errors.models.subscription.attributes.subscriber_id.taken_with_scope')
            }
end
