$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'rubygems'
require 'bundler/setup'
require 'make_model_searchable'
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
require 'support/schema'
require 'models/post'
require 'models/user'
require 'models/person'
require 'models/organization'

require 'rspec'
require 'factory_girl'

Bundler.setup

RSpec.configure do |config|
  config.mock_with :rspec
  config.expect_with :rspec
  config.raise_errors_for_deprecations!
  config.include FactoryGirl::Syntax::Methods	

  config.before(:suite) do
    FactoryGirl.find_definitions
  end
end