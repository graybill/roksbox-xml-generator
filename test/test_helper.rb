BASE_PATH = File.expand_path("#{File.dirname(__FILE__)}/..")
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'fakefs/safe'
require 'test/unit'
require 'httparty'