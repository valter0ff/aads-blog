# frozen_string_literal: true

require 'simplecov'

if ENV['RAILS_ENV'] == 'test'
  SimpleCov.start 'rails' do
    add_filter ['app/jobs', 'app/mailers', 'app/channels', '/config/', 'app/controllers/application_controller',
                'app/controllers/users/registrations_controller']
    add_group 'Controllers', 'app/controllers'
    add_group 'Models', 'app/models'
    add_group 'Helpers', 'app/helpers'
    minimum_coverage 30 # 80
  end
end
