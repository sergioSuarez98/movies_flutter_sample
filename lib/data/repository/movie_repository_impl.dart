import 'package:uponor_technical_test/data/datasources/movie_remote_data_source.dart';
import 'package:uponor_technical_test/domain/entities/movie.dart';
import 'package:uponor_technical_test/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Movie>> fetchMovies() async {
    return await remoteDataSource.getMovies();
  }

  @override
  Future<void> addMovie(Movie newMovie) async {
    await remoteDataSource.addMovie(newMovie);
  }

  @override
  Future<Movie> updateMovie(Movie updatedMovie) async {
    return await remoteDataSource.updateMovie(updatedMovie);
  }
}
