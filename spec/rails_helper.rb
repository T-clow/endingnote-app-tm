require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'capybara/rails'
require 'selenium-webdriver'
require 'database_cleaner-active_record'

if ENV['CI'] == 'true'
  Capybara.register_driver :selenium_remote_chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--disable-gpu')
    options.add_argument('--no-sandbox')
    options.add_argument('--window-size=1400,1400')
    options.add_preference('profile.default_content_setting_values.geolocation', 1)
    options.add_preference('profile.managed_default_content_settings.geolocation', 1)
    options.add_emulation(device_metrics: { latitude: 35.6895, longitude: 139.6917, accuracy: 100 })

    client = Selenium::WebDriver::Remote::Http::Default.new
    client.read_timeout = 120

    Capybara::Selenium::Driver.new(app,
      browser: :remote,
      url: "http://localhost:4444/wd/hub",
      capabilities: [options])
  end
  Capybara.javascript_driver = :selenium_remote_chrome
else
  Capybara.register_driver :selenium_remote_chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--disable-gpu')
    options.add_argument('--no-sandbox')
    options.add_argument('--window-size=1400,1400')
    options.add_preference('profile.default_content_setting_values.geolocation', 1)
    options.add_preference('profile.managed_default_content_settings.geolocation', 1)
    options.add_emulation(device_metrics: { latitude: 35.6895, longitude: 139.6917, accuracy: 100 })

    client = Selenium::WebDriver::Remote::Http::Default.new
    client.read_timeout = 120

    Capybara::Selenium::Driver.new(app,
      browser: :remote,
      url: "http://192.168.160.3:4444",
      capabilities: options)
  end
  Capybara.javascript_driver = :selenium_remote_chrome
end

Capybara.server_host = '0.0.0.0'
Capybara.server_port = 3001
Capybara.app_host = "http://#{IPSocket.getaddress(Socket.gethostname)}:#{Capybara.server_port}"

Capybara.configure do |config|
  config.default_max_wait_time = 20
end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include Devise::Test::IntegrationHelpers, type: :system
  config.include Warden::Test::Helpers
  config.include ActiveSupport::Testing::TimeHelpers
  config.include ActionView::Helpers::NumberHelper

  config.fixture_paths = [Rails.root.join('spec/fixtures')]
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
    ActiveRecord::Base.connection_pool.disconnect!
    ActiveRecord::Base.establish_connection
  end
end
