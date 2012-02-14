module Taggable  
  def self.included(base)
    base.class_eval do
      has_and_belongs_to_many :tags
      
      scope :tagged_with, (lambda do |names|
        joins(:tags).where(:tags => { :name => names }).uniq
      end)
      
      after_create :assign_tags
      after_create :increment_tags_counter_cache
      before_destroy :decrement_tags_counter_cache
    end
  end
  
  def assign_tags
    raw = Replaceable.new(content)
    self.tags = raw.tag_names.map do |name|    
      Tag.find_or_create_by_name(name)
    end
  end
  
  def increment_tags_counter_cache
    update_posts_counts
  end

  def decrement_tags_counter_cache
    update_posts_counts(-1)
  end
  
  def update_posts_counts(by = 1)
    tags.update_all("posts_count = posts_count + #{by}")
  end
end