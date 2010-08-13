class CreateMicroblogsAndMicroblogFollowings < ActiveRecord::Migration
  def self.up
    create_table :microblogs do |t|
      t.integer :author_id
      t.string :content
      t.string :record_belongs_to
      t.integer :record_foreign_key
      t.timestamps
    end
    add_index :microblogs, [:record_belongs_to, :record_foreign_key]
    create_table :microblog_followings do |t|
      t.integer :author_id
      t.integer :follower_id
      t.timestamps
    end
    add_index :microblog_followings, [:follower_id, :author_id], :unique => true
  end

  def self.down
    drop_table :microblogs
    drop_table :microblog_followings
  end
end
