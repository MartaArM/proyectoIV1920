class ElementoMM
	
	attr_accessor :nombre, :tipo, :valoracion, :acceso, :id
		
	def initialize(n, t, v, a, i)
		@nombre = n
		@tipo = t
		@valoracion = v
		@acceso = a
		@id = i
	end

end
