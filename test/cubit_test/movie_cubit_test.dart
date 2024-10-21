import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uponor_technical_test/domain/entities/movie.dart';
import 'package:uponor_technical_test/domain/repositories/movie_repository.dart';
import 'package:uponor_technical_test/domain/usecases/add_movie.dart';
import 'package:uponor_technical_test/domain/usecases/delete_movie.dart';
import 'package:uponor_technical_test/domain/usecases/get_movies.dart';
import 'package:uponor_technical_test/domain/usecases/update_movie.dart';
import 'package:uponor_technical_test/presentation/movies/cubit/movie_cubit.dart';

class MockMovieRepository extends MovieRepository {
  @override
  Future<void> addMovie(Movie newMovie) {
    // TODO: implement addMovie
    throw UnimplementedError();
  }

  @override
  Future<void> deleteMovie(Movie deletedMovie) {
    // TODO: implement deleteMovie
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> fetchMovies() {
    return Future.value([
      Movie(
        id: '1',
        title: 'Movie 1',
        releaseYear: 2022,
        rating: 10,
        posterUrl: 'mockedUrl',
      ),
    ]);
  }

  @override
  Future<Movie> updateMovie(Movie updatedMovie) {
    return Future.value(
      Movie(
        id: '1',
        title: 'Movie 1',
        releaseYear: 2022,
        rating: 10,
        posterUrl: 'mockedUrl',
      ),
    );
  }
}

class MockGetMovies extends GetMovies {
  MockGetMovies(super.repository);

  @override
  Future<List<Movie>> call() async {
    final movies = await repository.fetchMovies();
    return movies;
  }
}

class MockGetMoviesFailure extends GetMovies {
  MockGetMoviesFailure(MovieRepository repository) : super(repository);

  @override
  Future<List<Movie>> call() async {
    throw Exception("Failed to fetch movies");
  }
}

class MockAddMovie extends AddMovie {
  MockAddMovie(super.repository);

  @override
  Future<void> call(Movie newMovie) async {
    var allMovies = [
      Movie(
        id: '1',
        title: 'Movie 1',
        releaseYear: 2022,
        rating: 10,
        posterUrl: 'mockedUrl',
      ),
      newMovie,
    ];
  }
}

class MockAddMoviesFailure extends AddMovie {
  MockAddMoviesFailure(super.repository);

  @override
  Future<void> call(Movie newMovie) async {
    throw Exception("Failed to add movie");
  }
}

class MockUpdateMovie extends UpdateMovie {
  MockUpdateMovie(super.repository);

  @override
  Future<void> call(Movie updatedMovie) async {
    var movie = repository.updateMovie(updatedMovie);
  }
}

class MockUpdateMoviesFailure extends UpdateMovie {
  MockUpdateMoviesFailure(MovieRepository repository) : super(repository);

  @override
  Future<void> call(Movie updatedMovie) async {
    throw Exception("Failed to update movie");
  }
}

class MockDeleteMovie extends DeleteMovie {
  MockDeleteMovie(super.repository);

  @override
  Future<void> call(Movie deletedMovie) async {
    var allMovies = [];
  }
}

class MockDeleteMoviesFailure extends DeleteMovie {
  MockDeleteMoviesFailure(MovieRepository repository) : super(repository);

  @override
  Future<void> call(Movie deletedMovie) async {
    throw Exception("Failed to delete movie");
  }
}

void main() {
  late MovieCubit movieCubit;
  late MockGetMovies mockGetMovies;
  late MockAddMovie mockAddMovie;
  late MockUpdateMovie mockUpdateMovie;
  late MockDeleteMovie mockDeleteMovie;
  late MockMovieRepository repository;

  late MovieCubit errorMovieCubit;
  late MockGetMoviesFailure mockGetMoviesFailure;
  late MockAddMoviesFailure mockAddMoviesFailure;
  late MockUpdateMoviesFailure mockUpdateMoviesFailure;
  late MockDeleteMoviesFailure mockDeleteMoviesFailure;

  setUp(() {
    repository = MockMovieRepository();
    mockGetMovies = MockGetMovies(repository);
    mockAddMovie = MockAddMovie(repository);
    mockUpdateMovie = MockUpdateMovie(repository);
    mockDeleteMovie = MockDeleteMovie(repository);

    mockGetMoviesFailure = MockGetMoviesFailure(repository);
    mockAddMoviesFailure = MockAddMoviesFailure(repository);
    mockUpdateMoviesFailure = MockUpdateMoviesFailure(repository);
    mockDeleteMoviesFailure = MockDeleteMoviesFailure(repository);

    movieCubit = MovieCubit(
        mockGetMovies, mockAddMovie, mockUpdateMovie, mockDeleteMovie);
    errorMovieCubit = MovieCubit(mockGetMoviesFailure, mockAddMoviesFailure,
        mockUpdateMoviesFailure, mockDeleteMoviesFailure);
  });

  tearDown(() {
    movieCubit.close();
  });

  //fetchMovies test
  blocTest<MovieCubit, MovieState>(
    'emite [MovieLoading, MovieSuccess] cuando fetchMovies tiene éxito',
    build: () => movieCubit,
    act: (cubit) => cubit.fetchMovies(),
    expect: () => [
      MovieLoading(),
      isA<MovieSuccess>(),
    ],
  );

  // update movie test
  blocTest<MovieCubit, MovieState>(
    'emite [MovieLoading, AddMovieSuccess] cuando addNewMovie tiene éxito',
    build: () => movieCubit,
    act: (cubit) => cubit.addNewMovie(
      Movie(
          id: '2',
          title: 'Movie 2',
          releaseYear: 2023,
          rating: 2,
          posterUrl: 'mockedUrl'),
    ),
    expect: () => [
      MovieLoading(),
      AddMovieSuccess(),
    ],
  );

  // update movie test
  blocTest<MovieCubit, MovieState>(
    'emite [MovieLoading, UpdateMovieSuccess] cuando updateExistingMovie tiene éxito',
    build: () => movieCubit,
    act: (cubit) => cubit.updateExistingMovie(
      Movie(
        id: '1',
        title: 'Updated Movie',
        releaseYear: 2023,
        rating: 1,
        posterUrl: 'mockedUrl',
      ),
    ),
    expect: () => [
      MovieLoading(),
      UpdateMovieSuccess(),
    ],
  );

  //delete movie test
  blocTest<MovieCubit, MovieState>(
    'emite [MovieLoading, DeleteMovieSuccess] cuando deleteExistingMovie tiene éxito',
    build: () => movieCubit,
    act: (cubit) => cubit.deleteExistingMovie(
      Movie(
        id: '1',
        title: 'Movie to Delete',
        releaseYear: 2022,
        rating: 2,
        posterUrl: 'mockedURL',
      ),
    ),
    expect: () => [
      MovieLoading(),
      DeleteMovieSuccess(),
      MovieLoading(),
      MovieSuccess([])
    ],
  );
  //fetch movies error
  blocTest<MovieCubit, MovieState>(
    'emite [MovieLoading, MovieError] cuando fetchMovies falla',
    build: () => errorMovieCubit,
    act: (cubit) => cubit.fetchMovies(),
    expect: () => [
      MovieLoading(),
      isA<MovieError>(),
    ],
  );
  //add movie error
  blocTest<MovieCubit, MovieState>(
    'emite [MovieLoading, MovieError] cuando addMovie falla',
    build: () => errorMovieCubit,
    act: (cubit) => cubit.addNewMovie(
      Movie(
        id: '1',
        title: 'Added Movie',
        releaseYear: 2023,
        rating: 1,
        posterUrl: 'mockedUrl',
      ),
    ),
    expect: () => [
      MovieLoading(),
      isA<MovieError>(),
    ],
  );

  blocTest<MovieCubit, MovieState>(
    'emite [MovieLoading, MovieError] cuando updateMovie falla',
    build: () => errorMovieCubit,
    act: (cubit) => cubit.updateExistingMovie(
      Movie(
        id: '1',
        title: 'Updated Movie',
        releaseYear: 2023,
        rating: 1,
        posterUrl: 'mockedUrl',
      ),
    ),
    expect: () => [
      MovieLoading(),
      isA<MovieError>(),
    ],
  );

  blocTest<MovieCubit, MovieState>(
    'emite [MovieLoading, MovieError] cuando deleteMovie falla',
    build: () => errorMovieCubit,
    act: (cubit) => cubit.deleteExistingMovie(
      Movie(
        id: '1',
        title: 'Updated Movie',
        releaseYear: 2023,
        rating: 1,
        posterUrl: 'mockedUrl',
      ),
    ),
    expect: () => [
      MovieLoading(),
      isA<MovieError>(),
    ],
  );
}
