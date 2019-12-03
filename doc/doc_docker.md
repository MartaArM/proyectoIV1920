# Docker

## Contenedor en local

Para poder crear una imagen de nuestro servicio y arrancarlo en local, hay que crear un archivo llamado **Dockerfile**
`FROM ruby
WORKDIR /mymedia
COPY src ./src
COPY config.ru .
COPY Gemfile .
COPY Gemfile.lock .

EXPOSE 5000

RUN bundle install
CMD ["bundle","exec","rackup", "config.ru", "-p", "5000" ,"--host", "0.0.0.0"]`

* FROM ruby: se especifica que lenguaje está usando nuestra aplicación.
* WORKDIR /mymedia: nombre del directorio en el que vamos a trabajar
* COPY src ./src - COPY config.ru . - COPY Gemfile . - COPY Gemfile.lock . : copia los archivos necesarios para ejecutar nuestra aplicación en un contenedor.
* EXPOSE 5000: informa a Docker del puerto por el que se va a escuchar.
* RUN bundle install: instrucciones que ha de seguir Docker antes de arrancar nuestro microservicio.
* CMD ["bundle","exec","rackup", "config.ru", "-p", "5000" ,"--host", "0.0.0.0"]: instrucciones que tiene que seguir Docker para arrancar nuestro servicio. Se escuchara en cualquier dirección (por ejemplo, *localhost*) en el puerto 5000.

Para crear una imagen llamada *mymedia*, hay que ejecutar:
`docker build -t mymedia .`

Para arrancar un contenedor con esa imagen, ejecutamos:
`docker run -p 5000:5000 mymedia`

Ya solo tenemos que irnos a la dirección *127.0.0.1:5000* y podemos ver nuestro microservicio.

## Despliegue en Docker Hub

Desplegar en Docker Hub es muy sencillo: 
1. Primero, tenemos que darnos de alta en la [plataforma](https://hub.docker.com/)
2. Después, hay que crear un repositorio en **Repositories -> Create Repository+*
3. Podemos conectar nuestro repositorio de Github en el que tenemos nuestra aplicación para que cada vez que hagamos un push, se haga también en Docker Hub.

Repositorio en Docker Hub: https://hub.docker.com/r/marta22/mymediaiv

## Despliegue en Heroku

Para desplegar nuestro contenedor en Heroku, tenemos que crear un archivo llamado *heroku.yml*

`build:
  docker:
    web: Dockerfile

run:
  web: bundle exec rackup config.ru -p $PORT --host 0.0.0.0` 

En *run* hace lo mismo que el Dockerfile, solo que en vez de un puerto específico cogemos el puerto por defecto que tiene Heroku con *$PORT*. Simplemente, haciendo *git push* en nuestro repositorio ya se crea el contenedor directamente.