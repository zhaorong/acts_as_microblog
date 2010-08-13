class MicroblogFollowing < ActiveRecord::Base
  attr_accessible :author_id, :follower_id
end
