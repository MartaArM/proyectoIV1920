# Documentacion de la API

## General

En mi API hay:

- 4 llamadas GET:
    - get '/'
    - get '/status'
    - get '/elementos'
    - get '/elementos/:id'
- 1 llamada DELETE:
    - delete '/elementos/:id'
- 2 llamadas PUT:
    - put "/elementos"
    - put "/elementos/:id"

## Llamadas GET
    `get '/' do
		content_type :json
		{:status => 'OK'}.to_json
	end`

Si al hacer curl de la página principal (*http://localhost:9292/*) todo está correcto, muestra por pantalla **{:status => 'OK'}**

    `get '/status' do 
		content_type :json
		{:status => 'OK'}.to_json
	end`

Si al hacer curl de la página *http://localhost:9292/status* todo está correcto, muestra por pantalla **{:status => 'OK'}**

    `get '/elementos' do
		content_type :json
		@datos.to_json
	end`

Muestra todos los elementos que hay en el archivo.

    `get '/elementos/:id' do |id|
		content_type :json
		@datos["elementos"][id].to_json
	end`

Muestra el elemento identificado por **id**

## Llamada DELETE

    ´delete '/elementos/:id' do |id|
		@datos["elementos"].delete(id)
		File.open('src/elementos.json', "w") do |f|
			f.puts JSON.pretty_generate(@datos)
		end
		content_type :json
		{:status => 'OK'}.to_json
	end´

Elimina del archivo el elemento identificado por **id**. Lo que hace es que elimina el elemento del vector de datos que coge los datos del archivo y vuelve a meter esos datos en el archivo sobreescribiendo lo que había escrito.

## Llamadas PUT

    `put "/elementos" do
		elemento = JSON.parse(request.body.read)
		@datos['elementos'] = @datos["elementos"].merge(elemento)
		File.open('src/elementos.json', "w") do |f|
			f.puts JSON.pretty_generate(@datos)
		end
		content_type :json
		{:status => 'OK'}.to_json
	end`

Añade un elemento al archivo. Coge los datos que se añaden por POST a la llamada curl y lo añade al vector de elementos.

*Ejemplo de llamada curl: curl -X PUT -H "Content-Type: application/json" -d '{"3":{"nombre": "", "tipo": "", "valoracion": , "acceso": "", "id":3}}' http://localhost:9292/elementos/*

    `put "/elementos/:id" do |id|
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
	end`

Cambia la valoración del elemento identificado con por **id**. Tambén lo hace con datos en curl.

*Ejemplo de llamada curl: curl -X PUT -H "Content-Type: application/json" -d '5' http://localhost:9292/elementos/2* 