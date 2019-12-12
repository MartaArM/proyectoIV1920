#Indicamos que la versión del objeto de vagrant es la 2

Vagrant.configure("2") do |config|
	#Configuro la imagen en Ubuntu 16.04 Xenial
	config.vm.box = "ubuntu/xenial64"
	
	#Acceso al puerto 80 de la máquina virtual por el puerto 8931 del host
	config.vm.network "forwarded_port", guest: 80, host: 8931
	
	#Vamos a provisionar la máquina virtual con ansible
	
	config.vm.provision "ansible" do |ansible|
		ansible.playbook = "provision/playbook.yml"
	end
end
