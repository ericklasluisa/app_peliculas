import 'package:carousel_slider/carousel_slider.dart';
import 'package:crud_api/api/api.dart';
import 'package:crud_api/logica/peliculas.dart';
import 'package:flutter/material.dart';
import 'pantalla_lista.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  late Future<List<Pelicula>> peliculasPopulares;
  late Future<List<Pelicula>> peliculasBuscadas;
  String query = "";
  bool isSearching = false;
  List<Pelicula> peliculasPorVer = [];

  @override
  void initState() {
    peliculasPopulares = Api().peliculasPopulares();
    peliculasBuscadas = Future.value([]);
    super.initState();
  }

  void buscarPeliculas(String query) {
    setState(() {
      isSearching = true;
      peliculasBuscadas = Api().buscarPelicula(query);
    });
  }

  void agregarPelicula(Pelicula pelicula) {
    if (!peliculasPorVer.contains(pelicula)) {
      setState(() {
        peliculasPorVer.add(pelicula);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Película agregada a la lista'),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('La película ya está en la lista'),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void eliminarPelicula(int index) {
    setState(() {
      peliculasPorVer.removeAt(index);
    });
  }

  void editarPelicula(int index, Pelicula pelicula) {
    setState(() {
      peliculasPorVer[index] = pelicula;
    });
  }

  void marcarPeliculaComoVista(int index) {
    setState(() {
      peliculasPorVer[index].vista = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          backgroundColor: Colors.black12,
          foregroundColor: Colors.white,
          title: const Text("Peliculas"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.movie_edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PantallaLista(
                      peliculasPorVer: peliculasPorVer,
                      eliminarPelicula: eliminarPelicula,
                      editarPelicula: editarPelicula,
                    ),
                  ),
                );
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Peliculas y Series Populares",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                FutureBuilder(
                  future: peliculasPopulares,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final movies = snapshot.data!;

                    return CarouselSlider.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index, movieIndex) {
                        final movie = movies[index];
                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Stack(
                            children: [
                              const Center(child: CircularProgressIndicator()),
                              Image.network(
                                "https://image.tmdb.org/t/p/original${movie.backDropPath}",
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const Center(
                                      child: CircularProgressIndicator());
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(
                                      Icons.broken_image,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  );
                                },
                              ),
                              Positioned(
                                bottom: 8,
                                left: 8,
                                child: Text(
                                  movie.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    backgroundColor: Colors.black54,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 8,
                                right: 8,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  onPressed: () {
                                    agregarPelicula(movie);
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 1.4,
                        autoPlayAnimationDuration: const Duration(seconds: 2),
                        autoPlayInterval: const Duration(seconds: 5),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  "Buscar Películas o Series",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          query = value;
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Buscar películas o  series...',
                          hintStyle: TextStyle(color: Colors.white54),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search, color: Colors.white),
                          filled: true,
                          fillColor: Colors.black26,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: () {
                        buscarPeliculas(query);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (isSearching)
                  FutureBuilder(
                    future: peliculasBuscadas,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final movies = snapshot.data!;
                      if (movies.isEmpty) {
                        return const Text(
                          "No se encontraron resultados",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movie = movies[index];
                          return ListTile(
                            leading: Image.network(
                              "https://image.tmdb.org/t/p/w92${movie.posterPath}",
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.broken_image,
                                  color: Colors.white,
                                );
                              },
                            ),
                            title: Text(
                              movie.title,
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              movie.releaseDate,
                              style: const TextStyle(color: Colors.white70),
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.add_circle_outline,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                agregarPelicula(movie);
                              },
                            ),
                          );
                        },
                      );
                    },
                  )
                else
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: Text(
                        "Ingrese un término de búsqueda para encontrar películas.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ));
  }
}
