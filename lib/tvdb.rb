class Tvdb
  include HTTParty
  @base_uri = 'http://thetvdb.com/api/'
  format :xml

  def self.get_episode(seriesid, airdate)
    response = get(@base_uri + "GetEpisodeByAirDate.php?apikey=#{TVDB_API_KEY}&seriesid=#{seriesid}&airdate=#{airdate}")    
    response.parsed_response["Data"]
  end

  def self.get_series(name)
    response = get(@base_uri + "GetSeries.php?seriesname=#{URI.escape(name)}")
    response["Data"]["Series"]
  end

end