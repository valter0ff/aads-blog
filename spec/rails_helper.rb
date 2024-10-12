# frozen_string_literal: true

require_relative 'support/config/simplecov'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'

Dir['spec/support/pages/sections/*.rb', 'spec/support/pages/helpers/*.rb'].each { |file| require Rails.root.join(file) }

support_dir = File.join(File.dirname(__FILE__), 'support/**/*.rb')
Dir[File.expand_path(support_dir)].each do |file|
  require file unless file[/\A.+_spec\.rb\z/]
end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  config.fixture_paths = [Rails.root.join('spec', 'fixtures')]
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.use_transactional_fixtures = true

  config.include ActiveSupport::Testing::TimeHelpers
  config.include FactoryBot::Syntax::Methods
  config.include Rails.application.routes.url_helpers, type: :request
  config.include ActionDispatch::Integration::RequestHelpers
  config.include Devise::Test::IntegrationHelpers, type: :request
end
