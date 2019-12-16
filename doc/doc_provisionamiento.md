# Provisionamiento

La herramienta que voy a utilizar para crear la máquina virtual es [**Vagrant**](). El provisionamiento lo hare con [**Ansible**]().

## Vagrant

Para poder crear la máquina virtual, Vagrant necesita leer de un archivo llamado *Vagrantfile*.

`Vagrant.configure("2") do |config|
	config.vm.box = "bento/ubuntu-18.04"
	
	config.vm.network "forwarded_port", guest: 80, host: 8080
	
	config.vm.provider "virtualbox"
	
	config.vm.define "mymediaIV"
	
	config.vm.provision "ansible" do |ansible|
		ansible.playbook = "provision/playbook.yml"
	end
end`

* *Vagrant.configure("2") do |config|*: con esto queremos decir que la versión de Vagrant que se va utilizar es la 2 (*en mi caso la 2.2.6*)
* *config.vm.network "forwarded_port", guest: 80, host: 8080*: accedemos al puerto 80 de la máquina virtual a través del puerto 8080 del *host*
* *config.vm.provider "virtualbox"*: le decimos a Vagrant con qué herramienta vamos a crear la máquina virtual. En este caso, con VirtualBox.
* *config.vm.define "mymediaIV"*: el nombre de la máquina virtual será **mymediaIV**
* *config.vm.provision "ansible" ....*: el provisionamiento de la máquina virtual será con Ansible, y el archivo de configuración de Ansible (*playbook.yml*) estará en la carpeta *provision*

Para levantar la máquina, hay dos opciones:

* vagrant up --no-provision
* rake crearmv

Ambas crean la máquina sin hacer el provisionamiento.
## Ansible

Ansible es la herramienta que hará la privisión de la máquina virtual. Para saber que herramientas tiene que instalar en la máquina virtual, Ansible necesita un archivo llamado *playbook.yml* que, en mi caso, está en la carpeta **provision**.

`- hosts: all
    
    tasks:

      - name: Instalar dependencias
        command: bash -lc "apt-get update"
        become: true

      - name: Instalar ruby
        apt: pkg=ruby state=present
        become: true
        
      - name: Instalar nodeJS
        apt: pkg=nodejs state=present
        become: true
      
      - name: Instalar rbenv
        apt: pkg=rbenv state=present
        become: true

      - name: Instalar bundler
        apt: pkg=bundler state=present
        become: true
        
      - name: Instalar ruby-dev
        apt: pkg=ruby-dev state=latest
        become: true
        
      - name: Instalar rubygems
        apt: pkg=rubygems state=latest
        become: true
        
        
      - name: Clonar el repositorio
        git: repo=https://github.com/MartaArM/proyectoIV1920.git dest=MyMedia/  

      - bundler: state=present gemfile=MyMedia/Gemfile`

* Con las 7 primeras reglas, lo que hago es instalar varias herramientas que necesita mi aplicación, como el lenguaje Ruby, Bundler, etc.
* Con *name: Clonar el repositorio*, clono mi repositorio en la carpeta *MyMedia* de mi máquina virtual.
* En vez de ir instalando las "gemas" de una en una, he utilizado *bundler: state=present gemfile=MyMedia/Gemfile`*. Esto lo que hace es hacer "*bundler install*", indicandole que el archivo *Gemfile* está en la carpeta MyMedia

Para hacer el provisionamiento de la máquina (previamente creada) también hay dos opciones:

* vagrant provision
* rake provisionarmv

Para levantar y provisionar la máquina a la vez, se puede hacer:

* vagrant up --provision
* rake crearyprovisionar

# Vagrant Cloud

He subido mi máquina virtual a la plataforma [Vagrant Cloud](). 
 
1. Primero, hay que exportar nuestra máquina virtual haciendo `vagrant package --output mymedia.box`
2. Después, hay que irse a la página de Vagrant Cloud y crear una cuenta.
3. Una vez creada la cuenta, creamos una máquina virtual y le añadimos un *provider* en el que podemos subir nuestra máquina virtual.

> URL box: https://app.vagrantup.com/MartaArM/boxes/MyMediaIV

