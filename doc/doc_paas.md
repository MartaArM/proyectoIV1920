# Despliegue en Heroku

## Razones de uso

El PaaS que he utilizado para desplegar la aplicación es [Heroku](https://dashboard.heroku.com/apps).

He elegido este PaaS por varias razones:

- El cliente de Heroku se puede utilizar directa y fácilmente desde la terminal de Ubuntu. Simplemente haciendo `sudo snap install heroku` se instala el cliente.
- Es muy fácil de utilizar con Github. De hecho, para subir el código de la aplicación se usa *git*.
- Es gratuito.
- Como es muy usual, hay mucha información en internet. [El manual de Heroku](https://devcenter.heroku.com/articles/getting-started-with-ruby) es muy sencillo de entender.

## Configuración

1. Para empezar, como ya he comentado antes, hay que instalar el cliente de heroku en nuestro ordenador.
2. Después, hay que crearse una cuenta en Heroku (fácil, no te pide tarjeta de crédito).
3. A partir de este punto, ya podemos trabajar solo con la terminal de Ubuntu.
4. En la terminal, escribimos
`heroku login`
para meter nuestras credenciales. Se abrira una página web en la que simplemente tenemos que darle a **Log in**
5. Estando en el directorio donde está el código de nuestra aplicación, vamos a crear la app con
`heroku create nombreaplicacion`
Si no ponemos nombre de aplicación, genera el nombre aleatoriamente. En mi caso, el nombre de la aplicación es *mymediaiv*.
6. Antes de desplegar la aplicación, es necesario general el archivo *Gemfile.lock* (ya que yo estoy utilizando Ruby como lenguaje9. Para generarlo, basta con hacer `bundle install`.
7. Una vez generado mi archivo *Gemfile.lock*, ya puedo desplegar mi aplicación utilizando `git push heroku master`.
8. Por último, para abrir la aplicación hacemos `heroku open` y se nos abrirá un navegador con la página principal.

*Para configurar mi repositorio de Github con Heroku, hay que irse a la web de Heroku. En nuestra aplicación, nos vamos a la opcion **Deploy**, conectamos con nuestro Github, seleccionamos el repositorio que va a utilizar la aplicación y aceptamos para que cada vez que se haga un git en nuestro repo, se haga también en Heroku*