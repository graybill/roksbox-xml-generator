require 'json'

class Imdb
  include HTTParty

  @base_uri = "http://www.imdbapi.com/?t="
  def self.get_movie(response)
    response = get(@base_uri + URI.escape(response))    
    JSON.parse(response.parsed_response)
  end

end