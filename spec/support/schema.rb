ActiveRecord::Schema.define do
  self.verbose = false

  create_table :posts, force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

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

  add_foreign_key "posts", "users"
end
