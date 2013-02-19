require 'sinatra'
require 'sinatra/base'
require 'haml'

module Readouts
  class Web < Sinatra::Base
    
    dir = File.expand_path(File.dirname(__FILE__) + "/../../web")
    set :views,  "#{dir}/views"
    #set :public_folder, "#{dir}/public"

    helpers do
      #get some model data here
      def link_to(name,url)
        haml "%a{:href=> url } #{name}"
      end
    end

    get '/' do 
      @metrics_info = MetricsInfo.new
      @metrics_info.register_metric 'http_headers', request.env if @metrics_info.headers_enabled
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

