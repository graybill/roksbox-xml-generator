require File.expand_path("#{File.dirname(__FILE__)}/test_helper")
require "#{BASE_PATH}/config"
require "#{BASE_PATH}/lib/imdb"

class ImdbTest < Test::Unit::TestCase

  def setup
    p FakeWeb.register_uri(:get, "http://www.imdbapi.com", :body => "whee")
  end

  def test_get_movie_from_api    
    response = Imdb.get_movie("True Grit")
    assert_equal "True Grit", response["Title"]
  end

  def test_api_unavailable
    error_response = File.open("#{BASE_PATH}/test/fixtures/imdb_service_unavailable.html").read

  end

end