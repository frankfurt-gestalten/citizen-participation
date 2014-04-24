# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.include FactoryGirl::Syntax::Methods

  config.include LoginHelper, :type => :feature
  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers

  config.include Devise::TestHelpers, :type => :controller

  Fog.mock!
  if ENV['AWS_ACCESS_KEY_ID']
    connection = Fog::Storage.new(:provider => 'AWS', :aws_access_key_id => ENV['AWS_ACCESS_KEY_ID'], :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'], :region => ENV['FOG_REGION'])
    connection.directories.create(:key => ENV['FOG_DIRECTORY'])
  end

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false
  config.treat_symbols_as_metadata_keys_with_true_values = true

  config.filter_run :focus => true #put focus after it "sss" do <  to only show bug here

  config.run_all_when_everything_filtered = true
end
