require File.dirname(__FILE__) + '/test_helper'

class FooPost < ActiveRecord::Base
  belongs_to :user, :class_name => 'FooUser'
  acts_as_microblog_subject :has_many => :comments
  attr_accessible :user_id, :title, :content
end
class FooUser < ActiveRecord::Base
  has_many :posts, :class_name => 'FooPost'
  acts_as_microblog_author
  attr_accessible :login
end
class ActsAsMicroblogTest < ActiveSupport::TestCase
  load_schema
  def setup
    @tom = FooUser.create :login => 'Tom'
    @jack = FooUser.create :login => 'Jack'
    @post = FooPost.create :title => 'Tom post', :content => 'post content', :user_id => @tom.id
  end
  def test_should_acts_as_microblog_author
    @tom.follow @jack
    assert @tom.follow? @jack
    assert_equal @tom.following_ids, [@jack.id]
    assert_equal @jack.follower_ids, [@tom.id]
    @tom.unfollow @jack
    assert !@tom.follow?(@jack)
    assert_equal @tom.following_ids, []
    assert_equal @jack.follower_ids, []
  end
  def test_should_acts_as_microblog_subject
    @post.comments.create :content => 'Jack comment', :author_id => @jack.id
    assert_equal @post.comments.size, 1
    @post.comments.create :content => 'Tom comment', :author_id => @tom.id
    assert_equal @post.comments.size, 2
    tom_first_microblog = @tom.microblogs.first
    tom_first_microblog.comments.create :content => 'Jack comment for Tom comment', :author_id => @jack
    assert_equal tom_first_microblog.comments.size, 1
    assert_equal @post.comments.size, 2
  end
end
