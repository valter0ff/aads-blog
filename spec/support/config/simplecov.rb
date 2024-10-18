# frozen_string_literal: true

require 'simplecov'

SimpleCov.start 'rails' do
  add_filter ['app/jobs', 'app/mailers', 'app/channels', '/config/', 'app/controllers/application_controller',
              'app/controllers/users/registrations_controller']
  add_group 'Requests', 'app/controllers'
  add_group 'Models', 'app/models'
  add_group 'Helpers', 'app/helpers'
  minimum_coverage 80
end
