import 'package:uponor_technical_test/domain/entities/movie.dart';
import 'package:uponor_technical_test/domain/repositories/movie_repository.dart';

class DeleteMovie {
  final MovieRepository repository;

  DeleteMovie(this.repository);

  Future<void> call(Movie deletedMovie) async {
    await repository.deleteMovie(deletedMovie);
  }
}
