require 'active_support/all'
require 'hashie'

module Readouts
  APP_ROOT = File.join(File.dirname(__FILE__), '../')
  require 'readouts/metrics_info'
  require 'readouts/web'
  
  def self.configure(&block)
    MetricsInfo.config_block = block
  end
end
