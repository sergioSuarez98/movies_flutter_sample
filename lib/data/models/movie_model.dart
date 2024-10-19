import 'package:uponor_technical_test/domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required String id,
    required String title,
    required String description,
    required int releaseYear,
    required List<String> genre,
    required double rating,
    required String posterUrl,
  }) : super(
          id: id,
          title: title,
          description: description,
          releaseYear: releaseYear,
          genre: genre,
          rating: rating,
          posterUrl: posterUrl,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      releaseYear: json['releaseYear'],
      genre: List<String>.from(json['genre']),
      rating: json['rating'].toDouble(),
      posterUrl: json['posterUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'releaseYear': releaseYear,
      'genre': genre,
      'rating': rating,
      'posterUrl': posterUrl,
    };
  }
}
