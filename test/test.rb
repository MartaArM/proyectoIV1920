#!/usr/bin/env ruby

require  'test/unit'
require "json"

require_relative  '../src/ElementoMM'

class TestMyMedia <  Test::Unit::TestCase

	def setup 
		file = File.read('src/elemento.json')
		elem = JSON.parse(file)
		
		@elemento = ElementoMM.new(elem['nombre'], elem['tipo'], elem['valoracion'], elem['acceso'], elem['id'])
		
	end

	def test_valoracion
		if @elemento.valoracion < 0 || @elemento.valoracion > 10
			estado = "incorrecto"
		else 
			estado = "correcto"
		end
		assert_equal(estado, "correcto", "Valoracion correcta")
	end
	
	def test_tipo
		if @elemento.tipo =="Serie" || @elemento.tipo == "Película" || @elemento.tipo == "Libro" || @elemento.tipo == "Canción"
			estado = "correcto"
		else 
			estado = "incorrecto"
		end
		assert_equal(estado, "correcto", "Tipo correcto")
	end
end
