# CRUD API de Películas

![Flutter](https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png)

Este proyecto es una aplicación Flutter que permite buscar películas y series populares, así como gestionar una lista de películas por ver. La aplicación utiliza la API de The Movie Database (TMDb) para obtener información sobre las películas.

## Integrantes

- Erick Lasluisa
- Francisco Quiroga
- Ariel Rivadeneira
- Augusto Salazar

## Características

- Buscar películas y series populares.
- Añadir películas a una lista de "por ver".
- Marcar películas como vistas o no vistas.
- Eliminar películas de la lista.
- Mostrar un mensaje cuando no hay películas en la lista.

## Instalación

1. Clona este repositorio:

   ```bash
   git clone https://github.com/ericklasluisa/app_peliculas.git
   ```

2. Navega al directorio del proyecto:

   ```bash
   cd app_peliculas
   ```

3. Instala las dependencias:

   ```bash
   flutter pub get
   ```

## Uso

1. Ejecuta la aplicación:

   ```bash
   flutter run
   ```

2. La aplicación mostrará una lista de películas y series populares.
3. Puedes buscar películas utilizando la barra de búsqueda.
4. Añade películas a tu lista de "por ver" haciendo clic en el ícono de añadir.
5. Navega a la lista de películas por ver haciendo clic en el ícono de lista en la parte superior derecha.
6. Marca las películas como vistas o no vistas haciendo clic en el ícono de check.
7. Elimina películas de la lista haciendo clic en el ícono de eliminar.

## Estructura del Proyecto

- `lib/api/api.dart`: Contiene las funciones para interactuar con la API publica de TMDb (The Movie Database).
- `lib/logica/peliculas.dart`: Define la clase `Pelicula`.
- `lib/pantallas/pantalla_principal.dart`: Pantalla principal de la aplicación.
- `lib/pantallas/pantalla_lista.dart`: Pantalla de la lista de películas por ver.
