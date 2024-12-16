import 'dart:convert';

import 'package:crud_api/logica/peliculas.dart';
import 'package:http/http.dart' as http;

import 'package:crud_api/api/constants.dart';

class Api {
  final popularApiUrl =
      "https://api.themoviedb.org/3/trending/all/day?language=es-US&api_key=$apiKey";
  final buscarApiUrl =
      "https://api.themoviedb.org/3/search/movie?include_adult=false&language=es-US&page=1&api_key=$apiKey&query=";

  Future<List<Pelicula>> peliculasPopulares() async {
    final response = await http.get(Uri.parse(popularApiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['results'];

      List<Pelicula> peliculas =
          data.map((pelicula) => Pelicula.fromMap(pelicula)).toList();
      return peliculas;
    } else {
      throw Exception('Error al cargar las peliculas');
    }
  }

  Future<List<Pelicula>> buscarPelicula(String busqueda) async {
    final response = await http.get(Uri.parse(buscarApiUrl + busqueda));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['results'];

      List<Pelicula> peliculas =
          data.map((pelicula) => Pelicula.fromMap(pelicula)).toList();
      return peliculas;
    } else {
      throw Exception('Error al cargar las peliculas');
    }
  }
}
