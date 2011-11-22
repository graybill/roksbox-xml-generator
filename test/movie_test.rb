require File.expand_path("#{File.dirname(__FILE__)}/test_helper")
require "#{BASE_PATH}/lib/config"
require "#{BASE_PATH}/lib/movie"

class MovieTest < Test::Unit::TestCase
 
  def setup
    @file = "#{VIDEOS_PATH}/Movies/True.Grit.XvID102l3msadw.mp4"
    @response = File.open("#{BASE_PATH}/test/fixtures/imdb_api.js").read
  end

  def teardown
    
  end

  def test_set_initialized_attributes
    movie = Movie.new(@response, @file)
    assert movie.name, "True Grit"
    assert movie.year, "2010"
    assert movie.poster, "http://ia.media-imdb.com/images/M/MV5BMjIxNjAzODQ0N15BMl5BanBnXkFtZTcwODY2MjMyNA@@._V1._SX320.jpg"
    assert movie.file_path, @file
  end

end