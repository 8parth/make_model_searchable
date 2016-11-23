ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users, :force => true do |t|
    t.string :first_name
    t.string :last_name
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

	create_table :people, :force => true do |t|
    t.string :first_name
    t.string :last_name
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table :organizations, :force => true do |t|
    t.string :name
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end  
end
