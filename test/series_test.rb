require File.expand_path("#{File.dirname(__FILE__)}/test_helper")
require "#{BASE_PATH}/lib/config"
require "#{BASE_PATH}/lib/series"

class SeriesTest < Test::Unit::TestCase
 
  def setup
    @response = File.open("#{BASE_PATH}/test/fixtures/tvdb_api.xml").read
  end

  def test_set_initialized_attributes
    series = Series.new(@response, @file)
    assert series.name, "South Park"
    assert_match series.overview, /South Park is an animated series featuring four boys/
    assert series.tvdb_id, "75897"
  end

end