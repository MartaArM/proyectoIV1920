require 'sinatra'
require 'json'
require 'sinatra/base'

require_relative  '../src/ElementoMM'

class MyMedia < Sinatra::Base
	
	before do 
		archivo = File.read('src/elementos.json')
		@datos = JSON.parse(archivo)
		@elementos = []
		
	end
	
	get '/' do
		content_type :json
		{:status => 'OK'}.to_json
	end
	
	get '/status' do 
		content_type :json
		{:status => 'OK'}.to_json
	end

	get '/elementos' do
		content_type :json
		@datos.to_json
	end
	
	get '/elementos/:id' do |id|
		content_type :json
		@datos["elementos"][id].to_json
	end
	
	delete '/elementos/:id' do |id|
		@datos["elementos"].delete(id)
		File.open('src/elementos.json', "w") do |f|
			f.puts JSON.pretty_generate(@datos)
		end
		content_type :json
		{:status => 'OK'}.to_json
	end
	
	put "/elementos" do
		elemento = JSON.parse(request.body.read)
		@datos['elementos'] = @datos["elementos"].merge(elemento)
		File.open('src/elementos.json', "w") do |f|
			f.puts JSON.pretty_generate(@datos)
		end
		content_type :json
		{:status => 'OK'}.to_json
	end
	
	put "/elementos/:id" do |id|
		elemento = @datos["elementos"][id]
		@datos["elementos"].delete(id)
		elemento['valoracion'] = JSON.parse(request.body.read)
		el = elemento.to_json
		h = {1 => elemento}
		@datos['elementos'] = @datos["elementos"].merge(h)
		File.open('src/elementos.json', "w") do |f|
			f.puts JSON.pretty_generate(@datos)
		end
		content_type :json
		{:status => 'OK'}.to_json
	end
	
end


