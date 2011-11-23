require File.expand_path("#{File.dirname(__FILE__)}/test_helper")
require "#{BASE_PATH}/config"
require "#{BASE_PATH}/lib/episode"

class EpisodeTest < Test::Unit::TestCase

  def setup
    @response = File.open("#{BASE_PATH}/test/fixtures/tvdb_api_episode.xml").read
  end

  def test_set_initialized_attributes_with_tvdb
    episode = Episode.new(@response)
    assert_equal "Second Season First Episode", episode.name
    assert_equal "2", episode.season 
    assert_equal "1", episode.episode_no
    assert_match /Chuck Bartowski is an average computer geek/, episode.description
  end

end