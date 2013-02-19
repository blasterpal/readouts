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

end

