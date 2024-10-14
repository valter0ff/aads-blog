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

RSpec.describe User, type: :model do
  subject(:user) { create(:user) }

  describe 'database columns exists' do
    it { is_expected.to have_db_column(:email).of_type(:string) }
    it { is_expected.to have_db_column(:encrypted_password).of_type(:string) }
    it { is_expected.to have_db_column(:first_name).of_type(:string) }
    it { is_expected.to have_db_column(:last_name).of_type(:string) }
    it { is_expected.to have_db_column(:remember_created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:posts_count).of_type(:integer) }
  end

  describe 'database indexes exists' do
    it { is_expected.to have_db_index(:email).unique(true) }
  end

  describe 'ActiveModel validations' do
    let(:errors_path) { %w[activerecord errors models user attributes] }
    let(:blank_error) { I18n.t('activerecord.errors.messages.blank') }

    context 'when email' do
      let(:taken_error) { I18n.t('email.taken', scope: errors_path) }
      let(:invalid_error) { I18n.t('email.invalid', scope: errors_path) }

      it { is_expected.to validate_presence_of(:email).with_message(blank_error).on(:create) }
      it { is_expected.to validate_uniqueness_of(:email).case_insensitive.with_message(taken_error) }
      it { is_expected.to allow_value(FFaker::Internet.email).for(:email) }
      it { is_expected.not_to allow_value(FFaker::Lorem.word).for(:email).with_message(invalid_error) }
    end

    context 'when password' do
      let(:invalid_error) { I18n.t('password.invalid', scope: errors_path) }

      it { is_expected.to validate_presence_of(:password).with_message(blank_error).on(:create) }
      it { is_expected.to validate_length_of(:password).is_at_least(Constants::User::PASSWORD_MIN_SIZE) }
      it { is_expected.to validate_length_of(:password).is_at_most(Constants::User::PASSWORD_MAX_SIZE) }
      it { is_expected.to allow_value("#{FFaker::Internet.password}aA1").for(:password) }
      it { is_expected.not_to allow_value(FFaker::Lorem.phrase).for(:password).with_message(invalid_error) }
    end

    context 'when first_name' do
      it { is_expected.to validate_presence_of(:first_name).with_message(blank_error).on(:create) }
    end

    context 'when last_name' do
      it { is_expected.to validate_presence_of(:last_name).with_message(blank_error).on(:create) }
    end
  end

  describe 'associatios' do
    it { is_expected.to have_many(:posts).dependent(:destroy) }
  end
end
