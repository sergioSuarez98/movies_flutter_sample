import 'package:uponor_technical_test/domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required String id,
    required String title,
    required int releaseYear,
    required double rating,
    required String posterUrl,
  }) : super(
          id: id,
          title: title,
          releaseYear: releaseYear,
          rating: rating,
          posterUrl: posterUrl,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      releaseYear: json['releaseYear'],
      rating: json['rating'].toDouble(),
      posterUrl: json['posterUrl'],
    );
  }

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
