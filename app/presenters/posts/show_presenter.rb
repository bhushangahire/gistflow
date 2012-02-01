class Posts::ShowPresenter
  extend ActiveModel::Naming
  include Replaceable::Mentionable
  include Replaceable::Gistable
  
  attr_reader :record
  
  def initialize(post)
    @record = post
  end
  
  def body
    @record.replace_gists.replace_usernames.body
  end
  
  def method_missing(method)
    record.public_send(method) if record.respond_to? method
  end
end