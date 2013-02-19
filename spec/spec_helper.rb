ENV["RAILS_ENV"] ||= 'test'
require 'minitest/spec'
require 'minitest/autorun'
require "minitest/reporters"
MiniTest::Reporters.use!
require 'debugger'
require './lib/readouts'

Dir[File.join(APP_ROOT,"spec/support/**/*.rb")].each {|f| require f }
Dir.glob(File.join(APP_ROOT, 'lib/**/*.rb')).each {|f| require f}

include Readouts

require 'mustard'
# other niceities
Mustard.matcher(:be_true) { instance_of?TrueClass}

