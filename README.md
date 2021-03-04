# Marveloso
## Introducción
La idea del proyecto es probar la API de Marvel en una aplicación de iOS que liste todos los personajes y permita ver el detalle de cada uno de ellos, pero, además, existen una serie de elementos a tener en cuenta:
1. El lenguaje usado debe ser **Swift**. En este caso, he usado la 5 que es la versión que viene con el XCode 12
2. Emplear el **Interface Builder** para la creación de la interfaz gráfica y los **Storyboards** para definir la navegación entre pantallas
3. La arquitectura básica del proyecto será **MVP** (Model-View-Presenter)
## Instalación y pruebas
Los pasos a seguir para poder probar el proyecto son:
1. Clonar o descargar el repositorio  
   `$ git clone https://github.com/javimolla/marveloso.git`
2. Acceder al directorio raíz del repositorio  
   `$ cd marveloso`
3. Descargar todas las dependencias, que se gestionan con [CocoaPods](https://cocoapods.org/):  
    `$ pod install`
4. Crear el archivo `env-vars.sh` en el directorio raíz del repositorio con el contenido de las claves pública y privada del API de Marvel. El contenido del archivo debe ser el siguiente:  
   ```
   export MARVEL_PUBLIC_KEY=valor_clave_publica  
   export MARVEL_PRIVATE_KEY=valor_clave_privada
   ```
5. Abrir el proyecto con el archivo `marveloso.xcworkspace`
6. Compilar <kbd>⌘</kbd>+<kbd>B</kbd> el proyecto para que se genere la clase con las claves
7. Ejecutar <kbd>⌘</kbd>+<kbd>R</kbd> el proyecto o los tests <kbd>⌘</kbd>+<kbd>T</kbd> (hay dos planes de pruebas: `marvelosoTests`, con los tests unitarios del servicio y de los presentadores, y `kifTests`, con los tests de la interfaz gráfica)
## Créditos
Sin la documentación necesaria, no sería posible realizar ningún proyecto. Estos son algunos de los artículos que me han servido de guía y de ayuda en el desarrollo del proyecto:
* [Marvel API](https://developer.marvel.com/docs): panel interactivo para probar todos los métodos públicos de la API de Marvel. Hay que registrarse y obtener las claves públicas y privadas
* [Swagger Codegen](https://swagger.io/tools/swagger-codegen/) y [Swagger Spec de la API de Marvel](https://gist.github.com/wing328/30692487826e07962ae487dbb63a2fa1): para generar un cliente de la API de Marvel en cuestión de segundos. El Codegen soporta la especificación [OpenAPI](https://www.openapis.org/), por lo que es muy útil si la API a consumir está basada en dicha especificación
* [MVP](https://betterprogramming.pub/implement-a-model-view-presenter-architecture-in-swift-5-dfa21bbb8e0b): hay múltiples ejemplos que se pueden encontrar sobre cómo implementar la arquitectura MVP en iOS, pero éste es en el que más me he basado
* [Animación inicial](https://www.amerhukic.com/animating-launch-screen-using-gif): se trata de un efecto que se puede conseguir de un modo bastante sencillo y queda resultón, aunque la animación que yo he elegido igual tampoco es la que mejor permite apreciarlo
* [KIF testing](https://medium.com/lean-mind/test-de-ui-en-swift-con-kif-3249aac284e0): he querido seguir otro camino al que ofrece XCode para las pruebas de la interfaz gráfica y me he encontrado con este artículo en el que explican cómo hacerlo con KIF. En realidad, el artículo se basa en documentación de la empresa [Karumi](https://www.karumi.com/), un estudio de desarrollo de software con un gran enfoque en la calidad. Karumi tiene bastantes artículos y código público de gran calidad y utilidad. De hecho, tiene hasta [una kata sobre la API de Marvel](https://github.com/Karumi/KataSuperHeroesIOS/), la cual me he abstenido de leer para evitar que mi código se parezca demasiado al suyo y resulte una mera copia

Además de la documentación, estos son algunos de los recursos que aparecen en la aplicación:
* [Animación Marvel](https://acegif.com/marvel-gifs-animated-images/)
* [Icono Marvel](https://commons.wikimedia.org/wiki/File:MarvelLogo.svg)
* [Icono de listado vacío](https://thenounproject.com/term/bored/207824/)