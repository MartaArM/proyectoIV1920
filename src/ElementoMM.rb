class ElementoMM
	
	attr_accessor :nombre, :tipo, :valoracion, :acceso, :id
		
	def initialize(n, t, v, a, i)
		@nombre = n
		@tipo = t
		@valoracion = v
		@acceso = a
		@id = i
	end
	
	def to_json
		{"nombre" => @nombre ,
		"tipo" => @tipo,
		"valoracion" => @valoracion,
		"acceso" => @acceso,
		"id" => @id}.to_json
	end
	
	def setValoracion(n)
		@valoracion = n
	end
end
