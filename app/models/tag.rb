class Tag < ActiveRecord::Base
  has_many :followers
  has_many :users, :through => :followers
end
