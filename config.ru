require './lib/readouts'

Readouts::MetricsInfo.configure do |c|
  c.register_metric 'my_metric', {:foo => 'bar'}
  c.file_root = Dir[__FILE__] #to set relativy for finding REVISION file
  c.github_base_url = 'https://github.com/blasterpal/readouts'
  c.app_name = 'My Great App'
  c.headers_enabled = true
  c.version_info_enabled = true
end

run Readouts::Web

