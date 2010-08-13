class Microblog < ActiveRecord::Base
  # Relation
  acts_as_microblog_subject :has_many => :comments
  
  attr_accessible :author_id, :content, :record_belongs_to, :record_foreign_key
  
  def belongs_to; self.record_belongs_to; end
end
