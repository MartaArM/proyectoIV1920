#!/usr/bin/env ruby

require  'test/unit'
require "json"

require_relative  '../src/ElementoMM'

class TestMyMediaGen <  Test::Unit::TestCase
	include Rack::Test::Methods
	
	def test_status
		get '/status'
		assert_equal(last_response.body, '{"status":"OK"}', "status ok")
	end
	
	def test_elemento_id
		get '/elementos/1'
		assert last_response.ok?
		assert_equal(last_response.body, '{"nombre":"La casa de papel","tipo":"Serie", "valoracion":2, "acceso":"Netflix", "id":1}', "Encontrado elemento 1")
	end
	
	def test_delete
		get '/status'
		assert_equal(last_response.body, '{"status":"OK"}', "eliminada correctamente")
	end
end


