require 'sinatra'
require 'sinatra/base'

module Readouts
  class Web < Sinatra::Base
    
    dir = File.expand_path(File.dirname(__FILE__) + "/../web")
    set :views,  "#{dir}/views"

    helpers do
      #get some model data here
    end

    get '/' do 
      @metrics_info = MetricsInfo.new
      @metrics_info.register_metric 'http_headers', request.env if @metrics_info.headers_enabled
      @metrics_info.register_app_info 'version', @metrics_info.version_or_branch if @metrics_info.version_info_enabled
      haml :index
    end
    
    get '/main.css' do
      erb :'main.css'
    end

    get '/main.js' do
      erb :'main.js'
    end
  end
end
