module ActsAsMicroblog
  def self.included(base)
    base.send :extend, ClassMethods
  end
  module ClassMethods
    def acts_as_microblog_subject(options = {})
      has_many options[:has_many] || :microblogs,
        :class_name => 'Microblog',
        :foreign_key => 'record_foreign_key',
        :conditions => {'record_belongs_to' => class_name},
        :dependent => :destroy
    end
    def acts_as_microblog_author(options = {})
      Microblog.send :belongs_to, :author, :foreign_key => 'author_id', :class_name => class_name
      MicroblogFollowing.send :belongs_to, :followers, :class_name => class_name, :foreign_key => 'follower_id'
      MicroblogFollowing.send :belongs_to, :following, :class_name => class_name, :foreign_key => 'author_id'
      self.class_eval do
        has_many options[:has_many] || :microblogs,
          :foreign_key => 'author_id',
          :class_name => 'Microblog',
          :dependent => :destroy
        has_many :followers_through, :foreign_key => 'author_id', :class_name => 'MicroblogFollowing'
        has_many :followers, :through => :followers_through
        has_many :following_through, :foreign_key => 'follower_id', :class_name => 'MicroblogFollowing'
        has_many :following, :through => :following_through

        def follow(author)
          author.followers << self
          self
        end
        def follow?(author)
          author.followers.include? self
        end
        def unfollow(author)
          author.followers.delete self
          self
        end
      end
    end
  end
  module InstanceMethods

  end
end
ActiveRecord::Base.send :include, ActsAsMicroblog