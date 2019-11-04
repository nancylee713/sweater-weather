require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)

# Testing
require 'simplecov'
SimpleCov.start('rails')

# Shouda matchers
require 'rspec/rails'
require 'shoulda/matchers'

# Mocking
require 'vcr'
require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

VCR.configure do |config|
  # config.allow_http_connections_when_no_cassette = true
  config.ignore_localhost = true
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
end

def stub_weather_info
  start_city_data = File.open('./spec/fixtures/google_geocoding_data.json')
  stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=hongkong, &key=#{ENV['google_geocoding_api']}")
    .to_return(status: 200, body: start_city_data)

  antipode_data = File.open('./spec/fixtures/antipode_data.json')
  stub_request(:get, 'http://amypode.herokuapp.com/api/v1/antipodes?lat=22.3193039&long=114.1693611')
    .to_return(status: 200, body: antipode_data)

  antipode_city_data = File.open('./spec/fixtures/reverse_geocoding_data.json')
  stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?latlng=-22.3193039,-65.8306389&key=#{ENV['google_geocoding_api']}")
    .to_return(status: 200, body: antipode_city_data)

  weather_data = File.open('./spec/fixtures/weather_data.json')
  stub_request(:get, "https://api.darksky.net/forecast/#{ENV['dark_sky_api']}/-22.3193039,-65.8306389")
    .to_return(status: 200, body: weather_data)
end

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :selenium_chrome

Capybara.configure do |config|
  config.default_max_wait_time = 5
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec

      with.library :rails
    end
  end
end
