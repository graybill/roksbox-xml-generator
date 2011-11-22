require File.expand_path("#{File.dirname(__FILE__)}/test_helper")
require "#{BASE_PATH}/lib/config"
require "#{BASE_PATH}/lib/movie"

class MovieTest < Test::Unit::TestCase
 
  def setup
    @file = "#{VIDEOS_PATH}/Movies/True.Grit.XvID102l3msadw.mp4"
    response = File.open("#{BASE_PATH}/test/fixtures/imdb_api.js").read
    @movie = Movie.new(response, @file)  
  end

  def test_set_initialized_attributes_with_imdb_api
    assert_equal @movie.name, "True Grit"
    assert_equal @movie.year, "2010"
    assert_equal @movie.poster, "http://ia.media-imdb.com/images/M/MV5BMjIxNjAzODQ0N15BMl5BanBnXkFtZTcwODY2MjMyNA@@._V1._SX320.jpg"
    assert_match @movie.description, /A tough U.S. Marshal helps a stubborn/
    assert_equal @movie.rated, "PG-13"
  end

  def test_convert_runtime_to_minutes
    assert_equal @movie.runtime, 110
  end

  def test_convert_file_path_to_server_path
    assert_equal "#{ROKSBOX_PATH}/Movies/True.Grit.XvID102l3msadw.mp4", @movie.file_path
  end

end