$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'bundler/setup'
Bundler.setup

require 'make_model_searchable'
require 'models/user'
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users, :force => true do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end
end