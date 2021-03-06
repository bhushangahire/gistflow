module Github
  class Gist
    extend ActiveModel::Naming
    attr_accessor :id, :description, :html_url, :lang
    
    def initialize(id_or_attributes)
      if id_or_attributes.is_a? Hash
        id_or_attributes.each do |key, value|
          send "#{key}=", value
        end
      else
        id = id_or_attributes
      end
    end
    
    def self.all(username)
      raw = API.json URI("#{API::URL}/users/#{username}/gists")
      extract_gists(raw)
    end
    
    def self.find(id)
      API.json URI("https://gist.github.com/#{id}.json")
    end
    
    def name
      description.present? ? description : id
    end
  
  protected
    
    def self.extract_gists(raw)
      raw.map do |gist|
        new(
          :description => gist['description'],
          :id => gist['id'],
          :lang => gist['files'].values.first['language'].to_s.downcase
        ) 
      end
    end
  end
end