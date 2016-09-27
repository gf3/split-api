require 'sinatra/base'
require 'split'
require 'multi_json'

module Split
  class API < Sinatra::Base
    enable :sessions
    disable :protection
    helpers Split::Helper

    get '/ab_test' do
      experiment = params[:experiment]
      control = params[:control]
      alternatives = params[:alternatives]
      alternative = ab_test(experiment, control, *alternatives)
      MultiJson.encode({:alternative => alternative})
    end

    post '/finished' do
      experiment = params[:experiment]
      finished(experiment)
      200
    end
  end
end
