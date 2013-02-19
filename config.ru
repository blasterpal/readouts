require './lib/readouts'

Readouts::MetricsInfo.configure do |c|
  # configure the basics about your app
  c.app_name = 'My Great App'
  c.github_base_url = 'https://github.com/blasterpal/readouts'
  c.file_root = Dir[__FILE__] #to set relativy for finding REVISION file
  # enable features 
  c.headers_enabled = true
  c.version_info_enabled = true
  #register metrics 
  c.register_metric 'my_metric', {:foo => 'bar'}
end

run Readouts::Web

