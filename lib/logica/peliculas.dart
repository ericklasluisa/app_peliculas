class Pelicula {
  final String title;
  final String backDropPath;
  final String overview;
  final String posterPath;
  final String releaseDate;
  bool vista;

  Pelicula({
    required this.title,
    required this.backDropPath,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    this.vista = false,
  });

  factory Pelicula.fromMap(Map<String, dynamic> map) {
    return Pelicula(
      title: map['title'] ?? map['name'] ?? 'Título no disponible',
      backDropPath: map['backdrop_path'] ?? '',
      overview: map['overview'] ?? 'Sin descripción disponible',
      posterPath: map['poster_path'] ?? '',
      releaseDate: map['release_date'] ?? 'Fecha no especificada',
      vista: map['vista'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'backdrop_path': backDropPath,
      'overview': overview,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'vista': vista,
    };
  }
}
