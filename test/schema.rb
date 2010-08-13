ActiveRecord::Schema.define(:version => 0) do
  create_table :foo_users, :force => true do |t|
    t.string :login
    t.timestamps
  end
  create_table :foo_posts, :force => true do |t|
    t.integer :user_id
    t.string :title
    t.text :content
    t.timestamps
  end
  create_table :microblogs, :force => true do |t|
    t.integer :author_id
    t.string :content
    t.string :record_belongs_to
    t.integer :record_foreign_key
    t.timestamps
  end
  add_index :microblogs, [:record_belongs_to, :record_foreign_key]
  create_table :microblog_followings, :force => true do |t|
    t.integer :author_id
    t.integer :follower_id
    t.timestamps
  end
  add_index :microblog_followings, [:follower_id, :author_id], :unique => true
end