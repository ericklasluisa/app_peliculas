import 'package:flutter/material.dart';
import 'package:crud_api/logica/peliculas.dart';

class PantallaLista extends StatefulWidget {
  final List<Pelicula> peliculasPorVer;
  final Function(int) eliminarPelicula;
  final Function(int, Pelicula) editarPelicula;

  const PantallaLista({super.key, 
    required this.peliculasPorVer,
    required this.eliminarPelicula,
    required this.editarPelicula,
  });

  @override
  _PantallaListaState createState() => _PantallaListaState();
}

class _PantallaListaState extends State<PantallaLista> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: const Text("Lista de Películas por Ver"),
        backgroundColor: Colors.black12,
        foregroundColor: Colors.white,
      ),
      body: widget.peliculasPorVer.isEmpty
          ? const Center(
              child: Text(
                "Aún no hay películas en la lista",
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: widget.peliculasPorVer.length,
              itemBuilder: (context, index) {
                final pelicula = widget.peliculasPorVer[index];
                return ListTile(
                  leading: Image.network(
                    "https://image.tmdb.org/t/p/w92${pelicula.posterPath}",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.broken_image,
                        color: Colors.white,
                      );
                    },
                  ),
                  title: Text(
                    pelicula.title,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pelicula.releaseDate,
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                        decoration: BoxDecoration(
                          color: pelicula.vista ? Colors.green : Colors.yellow,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          pelicula.vista ? "Vista" : "No vista",
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check_circle, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            pelicula.vista = !pelicula.vista;
                            widget.editarPelicula(index, pelicula);
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            widget.eliminarPelicula(index);
                          });
                        },
                      ),
                    ],
                  ),
                  tileColor: pelicula.vista ? Colors.green.withOpacity(0.2) : null,
                );
              },
            ),
    );
  }
}
