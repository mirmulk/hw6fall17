class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
 class Movie::InvalidKeyError < StandardError ; end
 Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb26562") 
  def self.find_in_tmdb(string)
    array_hashes = []
    
    begin
      array_search = Tmdb::Movie.find(string)
    rescue Tmdb::InvalidApiKeyError
        raise Movie::InvalidKeyError, 'Invalid API key'
    end
    array_search.each do |i|
       rating_tmdb = Tmdb::Movie.releases(i.id)["countries"]
        rating = ""
          rating_tmdb.each do |n|
            if n["iso_3166_1"].upcase == 'US'
              rating = n['certification']
            end
          end
      hash = {}
      hash[:tmdb_id] = i.id
      hash[:title] = i.title
      hash[:release_date] = i.release_date
      hash[:rating] = rating
      array_hashes.push(hash)
    end
   return array_hashes
  end
end
