require './lib/readouts'

Readouts::MetricsInfo.configure do |c|
  c.register_metric 'my_metric', {:foo => 'bar'}
  c.register_app_info 'app_name', 'Readouts'
  c.register_app_info 'github_base_url', 'https://github.com/blasterpal/readouts'
  c.headers_enabled = true
end

run Readouts::Web

