require 'nokogiri'

class Series
  include HTTParty

  attr_accessor :name, :poster, :overview, :tvdb_id

  def initialize(response, original_file)
    response = Nokogiri.parse(response)
    self.name=response.css('SeriesName').text
    self.overview=response.css('Overview').text
    self.tvdb_id=response.css('seriesid').text
    # TODO get absolute path
    # self.poster=response.css('banner').text
  end

end