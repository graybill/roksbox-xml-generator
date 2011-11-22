require File.expand_path("#{File.dirname(__FILE__)}/test_helper")
require "#{BASE_PATH}/lib/config"
require "#{BASE_PATH}/lib/roksbox_file"

class RoksboxFileTest < Test::Unit::TestCase

  def setup
    FakeFS.activate!
    @file = RoksboxFile.new
    # Create file structure
    dirs = ["/Movies", "/Television/South Park/Season 1", "/Television/South Park/Season 2"]
    dirs.map { |dir| FileUtils.mkdir_p(dir) }
  end

  def teardown
    FakeFS.deactivate!
  end

  def test_get_directories
    assert Dir.exists?("/Movies")
    assert Dir.exists?("/Television\/South Park\/Season 1")
    assert Dir.exists?("/Television\/South Park\/Season 2")
  end

  def test_xml_file_creation
    @file.build_xml_file
    assert File.exist?("video.xml")
  end

end