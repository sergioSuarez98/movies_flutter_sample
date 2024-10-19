import 'package:uponor_technical_test/domain/entities/movie.dart';
import 'package:uponor_technical_test/domain/repositories/movie_repository.dart';

class GetMovies {
  final MovieRepository repository;

  GetMovies(this.repository);

  Future<List<Movie>> call() async {
    return await repository.fetchMovies();
  }
}
