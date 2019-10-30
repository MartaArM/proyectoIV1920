require 'sinatra'
require 'json'
require 'sinatra/base'

class MyMedia < Sinatra::Base
	
	get '/status' do 
		content_type :json
		{:status => 'OK'}.to_json
	end

end
