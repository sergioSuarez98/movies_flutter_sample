import 'package:uponor_technical_test/domain/entities/movie.dart';
import 'package:uponor_technical_test/domain/repositories/movie_repository.dart';

class AddMovie {
  final MovieRepository repository;

  AddMovie(this.repository);

  Future<void> call(Movie newMovie) async {
    await repository.addMovie(newMovie);
  }
}
