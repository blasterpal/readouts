ENV["RAILS_ENV"] ||= 'test'
require 'minitest/spec'
require 'minitest/autorun'
require "minitest/reporters"
require 'mustard'
MiniTest::Reporters.use! #MiniTest::Reporters::SpecReporter
require 'debugger'

APP_ROOT = File.join(File.dirname(__FILE__), '../')
require './lib/readouts'
include Readouts
Dir.glob(File.join(APP_ROOT, 'lib/**/*.rb')).each {|f| require f}

# other niceities
Mustard.matcher(:be_true) { instance_of?TrueClass}

