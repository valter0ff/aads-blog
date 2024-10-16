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

RSpec.describe Post, type: :model do
  subject(:post) { create(:post) }

  describe 'database columns exists' do
    it { is_expected.to have_db_column(:body).of_type(:text) }
    it { is_expected.to have_db_column(:title).of_type(:string) }
  end

  describe 'database indexes exists' do
    it { is_expected.to have_db_index(:user_id) }
  end

  describe 'associatios' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'ActiveModel validations' do
    let(:blank_error) { I18n.t('activerecord.errors.messages.blank') }

    context 'when title' do
      it { is_expected.to validate_presence_of(:title).with_message(blank_error).on(:create) }
      it { is_expected.to validate_length_of(:title).is_at_most(Constants::Post::TITLE_MAX_SIZE) }
    end

    context 'when body' do
      it { is_expected.to validate_presence_of(:body).with_message(blank_error).on(:create) }
      it { is_expected.to validate_length_of(:body).is_at_most(Constants::Post::BODY_MAX_SIZE) }
    end
  end

  describe '#counter_culture' do
    let(:user) { create(:user) }

    before { create(:post, user:) }

    it { expect(user.reload.posts_count).to eq(1) }
  end
end
