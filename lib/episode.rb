class Episode
  include HTTParty
  attr_accessor :series, :name, :season, :episode_no

  def initialize(response)
    response = Nokogiri.parse(response)
    @name = response.css('EpisodeName').text
    @season = response.css('Combined_season').text
    @episode_no = response.css('Combined_episodenumber').text
  end

end