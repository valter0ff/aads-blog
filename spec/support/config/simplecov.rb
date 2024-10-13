# frozen_string_literal: true

require 'simplecov'

SimpleCov.start 'rails' do
  add_filter ['app/jobs', 'app/mailers']
  minimum_coverage 30 # 80
end
