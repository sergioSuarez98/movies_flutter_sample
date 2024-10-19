class Movie {
  final String id;
  final String title;
  final String description;
  final int releaseYear;
  final List<String> genre;
  final double rating;
  final String posterUrl;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.releaseYear,
    required this.genre,
    required this.rating,
    required this.posterUrl,
  });
}
