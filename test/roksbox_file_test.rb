require File.expand_path("#{File.dirname(__FILE__)}/test_helper")
require "#{BASE_PATH}/lib/config"
require "#{BASE_PATH}/lib/roksbox_file"

class RoksboxFileTest < Test::Unit::TestCase

  def setup
    FakeFS.activate!
    @file = RoksboxFile.new
  end

  def teardown
    FakeFS.deactivate!
  end

  def test_list_directories
    dirs = ["/Movies", "/Television", "/Television/South Park"]
    dirs.each do |dir|
      Dir.mkdir(dir)
    end
    # Dir.mkdir("/Television/South Park")
    # Dir.mkdir("/Television/South Park/Season 1")
    # Dir.mkdir("/Television/South Park/Season 2")
    assert_match @file.get_directories("/"), /Movies/
  end

  def test_xml_file_creation
    @file.build_xml_file
    assert File.exist?("video.xml")
  end

end