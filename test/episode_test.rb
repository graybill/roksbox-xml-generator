require File.expand_path("#{File.dirname(__FILE__)}/test_helper")
require "#{BASE_PATH}/lib/config"
require "#{BASE_PATH}/lib/episode"

class EpisodeTest < Test::Unit::TestCase

  def setup
    @response = File.open("#{BASE_PATH}/test/fixtures/tvdb_api_episode.xml").read
  end

  def test_set_initialized_attributes_with_tvdb
    episode = Episode.new(@response)
    assert_equal episode.name, "Second Season First Episode"
    assert_equal episode.season, "2"
    assert_equal episode.episode_no, "1"

  end

end