import 'package:uponor_technical_test/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> fetchMovies();
}
