class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :likable, :polymorphic => true
  
  validates :user_id, :uniqueness => { :scope => [:likable_id, :likable_type] }
  validates :user, :exclusion => { :in => proc(&:unavailable_users) }
  
  def unavailable_users
    [likable.user]
  end
end
