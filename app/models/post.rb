# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  body       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  validates :title, presence: { on: :create },
                    length: { maximum: Constants::Post::TITLE_MAX_SIZE }
  validates :body, presence: { on: :create },
                   length: { maximum: Constants::Post::BODY_MAX_SIZE }

  belongs_to :user
  has_many :comments, dependent: :destroy

  counter_culture :user
end
