#Indicamos que la versión del objeto de vagrant es la 2

Vagrant.configure("2") do |config|
	#Configuro la imagen en 
	config.vm.box = "bento/ubuntu-18.04"
	
	#Acceso al puerto 80 de la máquina virtual por el puerto 8080 del host
	config.vm.network "forwarded_port", guest: 80, host: 8080
	
	config.vm.provider "virtualbox"
	
	config.vm.define "mymediaIV"
	
	#Vamos a provisionar la máquina virtual con ansible
	config.vm.provision "ansible" do |ansible|
		ansible.playbook = "provision/playbook.yml"
	end
end
