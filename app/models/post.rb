class Post < ActiveRecord::Base
  include Models::Likable
  include Models::Notifiable
  include Models::Taggable
  include Models::Searchable unless Rails.env.test?
  
  belongs_to :user, :inverse_of => :posts
  has_many :comments
  
  default_scope :order => 'id desc'
  
  validates :user, :presence => true
  validates :title, :presence => true
  validates :cuts_count, :inclusion => { :in => [0, 1] }
  validates :preview, :length => 3..500
  validates :tags_size, :numericality => { :greater_than => 0 }
  validates :status, format: { with: /http:\/\/goo.gl\/xxxxxx/ }, 
    length: { maximum: 140 }, :if => :status?
  
  attr_accessor :status
  attr_accessible :title, :content, :question, :status
  
  after_create :tweet
  
  scope :from_followed_users, lambda { |user| followed_by(user) }
  
  def link_name
    ln = title.blank? ? preview : title
    ln[0..30].strip
  end
  
  def preview
    content_parts.first.to_s.strip
  end
  
  def body
    content.to_s.gsub('<cut>', "\r\n")
  end
  
  def tags_size
    raw = Replaceable.new(content)
    raw.tagnames.size
  end
  
  def status?
    status.present?
  end
  
protected
  
  def cuts_count
    if content.blank?
      0
    elsif content == '<cut>'
      1
    else
      content.split('<cut>').size - 1
    end
  end
  
  def content_parts
    @content_parts ||= content.to_s.split('<cut>', 2)
  end
  
  def tweet
    if user.twitter_client? && status.present?
      url = Googl.shorten("http://gistflow.com/posts/#{id}")
      status.gsub!('http://goo.gl/xxxxxx', '')
      status << url.short_url
      user.twitter_client.update(status)
    end
  end
  
  def self.followed_by(user)
    followed_user_ids = %(SELECT followed_user_id FROM followings
                          WHERE follower_id = :user_id)
    where("user_id IN (#{followed_user_ids})", { user_id: user })
  end
end
