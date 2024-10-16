# frozen_string_literal: true

source 'https://rubygems.org'

ruby(File.read(File.join(File.dirname(__FILE__), '.ruby-version')).strip)

# System
gem 'ar_lazy_preload'
gem 'bootsnap', require: false
gem 'counter_culture'
gem 'cssbundling-rails'
gem 'jbuilder'
gem 'jsbundling-rails'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.1.4'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'

# ActiveRecord models as a tree
gem 'ancestry'

# Views
gem 'haml-rails', '~> 2.0'
gem 'simple_form', '~> 5.1.0'

# Authentication
gem 'devise', '~> 4.9.0'

# Decorators/View-Models for Rails Applications
gem 'draper'

# Pagination
gem 'pagy', '~> 5.10.1'

# Migration validation
gem 'strong_migrations'

group :development, :test do
  gem 'bullet'
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'i18n-tasks', '~> 1.0.14'
  gem 'rspec-rails'
  gem 'shoulda-matchers', '~> 6.0'

  # Code quality
  gem 'brakeman', require: false
  gem 'debug', platforms: %i[mri windows]
  gem 'fasterer', require: false
  gem 'haml_lint', require: false
  gem 'lefthook', '~> 1.7.2'
  gem 'rails_best_practices', require: false
  gem 'rails_sql_prettifier'
  gem 'rubocop', '~> 1.26', require: false
  gem 'rubocop-capybara', require: false
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
  gem 'activerecord-import'
  gem 'annotate'
  gem 'awesome_print'
  gem 'better_errors'
  gem 'database_consistency', require: false
  gem 'ruby-lsp'
  gem 'spring'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'cuprite'
  gem 'database_cleaner-active_record'
  gem 'rack_session_access'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
  gem 'site_prism'
  gem 'webdrivers'
end
