class Movie {
  final String id;
  final String title;
  final int releaseYear;
  final double rating;
  final String posterUrl;

  Movie({
    required this.id,
    required this.title,
    required this.releaseYear,
    required this.rating,
    required this.posterUrl,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'releaseYear': releaseYear,
      'rating': rating,
      'posterUrl': posterUrl,
    };
  }
}
