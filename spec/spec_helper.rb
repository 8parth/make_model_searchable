$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'bundler/setup'
Bundler.setup

require 'make_model_searchable'
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
require 'support/schema'

require 'models/user'
require 'yaml'
# self.set_fixture_class '/models/users' => User
YAML.load "fixtures/*"
# require 'fixtures/users.yml'
# require 'fixtures/persons.yml'