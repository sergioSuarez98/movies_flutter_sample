import 'package:uponor_technical_test/domain/entities/movie.dart';
import 'package:uponor_technical_test/domain/repositories/movie_repository.dart';

class UpdateMovie {
  final MovieRepository repository;

  UpdateMovie(this.repository);

  Future<void> call(Movie editedMovie) async {
    await repository.updateMovie(editedMovie);
  }
}
