# frozen_string_literal: true

require 'database_cleaner-active_record'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean
