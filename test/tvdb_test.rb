require File.expand_path("#{File.dirname(__FILE__)}/test_helper")
require "#{BASE_PATH}/config"
require "#{BASE_PATH}/lib/tvdb"

require 'nokogiri'

class TvdbTest < Test::Unit::TestCase

  def setup
    # use FakeWeb?
    # currently needs an internet connection, sad bear
  end

  # NOTE: Currently testing API responses which probably shouldn't be tested, but could sure help if they change the API

  def test_get_series_from_api
    response = Tvdb.get_series("South Park")
    assert_equal "75897", response["seriesid"]
  end

  def test_get_first_series_when_multiples
    response = Tvdb.get_series("Lost")
    assert_equal "73739", response["seriesid"]
  end

  def test_get_episode_from_api
    response = Tvdb.get_episode("80348", "2007-09-24")
    assert response["Episode"]
    assert_equal "332179", response["Episode"]["id"]
  end

  def test_get_episode_handle_no_results
    response = Tvdb.get_episode("80348", "2007-09-26")
    assert response["Error"]
    assert_equal "No Results from SP", response["Error"]
  end

end