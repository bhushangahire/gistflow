class Post < ActiveRecord::Base
  include Replaceable::Mentionable
  include Replaceable::Gistable
  
  belongs_to :user
  
  has_many :comments
  default_scope :order => 'created_at DESC'
  
end
