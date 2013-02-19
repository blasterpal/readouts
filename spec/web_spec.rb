require './spec/spec_helper'
require 'rack/test'

describe Web do 
  include Rack::Test::Methods
  def app
    Web
  end
  it "should respond OK on zero configuration" do
    get "/"
    last_response.ok?.must.be_true
  end
  describe "#try_showing_data" do
    it "should not show anything if methods are nil" do 
    MetricsInfo.configure do |c|
      c.register_app_info 'app_name', 'Readouts'
      c.register_app_info 'file_root', APP_ROOT
      c.register_app_info 'github_base_url', 'https://github.com/blasterpal/readouts'
    end
    @metrics_info = MetricsInfo.new
    get '/'
    app.try_showing_data(@metrics_info,:app_info,:foo).must.equal ''
    end

  end

end

