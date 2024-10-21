import 'package:uponor_technical_test/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> fetchMovies();
  Future<void> addMovie(Movie newMovie);
  Future<Movie> updateMovie(Movie updatedMovie);
  Future<void> deleteMovie(Movie deletedMovie);
}
