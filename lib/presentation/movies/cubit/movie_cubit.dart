// ignore_for_file: lines_longer_than_80_chars
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uponor_technical_test/domain/entities/movie.dart';
import 'package:uponor_technical_test/domain/usecases/add_movie.dart';
import 'package:uponor_technical_test/domain/usecases/delete_movie.dart';
import 'package:uponor_technical_test/domain/usecases/get_movies.dart';
import 'package:uponor_technical_test/domain/usecases/update_movie.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final GetMovies getMovies;
  final AddMovie addMovie;
  final UpdateMovie updateMovie;
  final DeleteMovie deleteMovie;
  MovieCubit(this.getMovies, this.addMovie, this.updateMovie, this.deleteMovie)
      : super(MovieInitial());

  Future<void> fetchMovies() async {
    emit(MovieLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      final movies = await getMovies();

      emit(
        MovieSuccess(movies),
      );
    } on Exception catch (e) {
      emit(
        MovieError(
          e.toString(),
        ),
      );
    }
  }

  Future<void> addNewMovie(Movie newMovie) async {
    emit(MovieLoading());

    try {
      await addMovie(newMovie);
      emit(
        AddMovieSuccess(),
      );
    } on Exception catch (e) {
      emit(
        MovieError(
          e.toString(),
        ),
      );
    }
  }

  Future<void> updateExistingMovie(Movie updatedMovie) async {
    emit(MovieLoading());

    try {
      await updateMovie(updatedMovie);
      emit(
        UpdateMovieSuccess(),
      );
    } on Exception catch (e) {
      emit(
        MovieError(
          e.toString(),
        ),
      );
    }
  }

  Future<void> deleteExistingMovie(Movie deletedMovie) async {
    emit(MovieLoading());
    try {
      await deleteMovie(
          deletedMovie); // Llama a la lógica para eliminar la película
      emit(DeleteMovieSuccess()); // Este estado debe emitirse
      await fetchMovies(); // Asegúrate de que fetchMovies() esté actualizando el estado
    } catch (error) {
      emit(MovieError('Failed to delete movie'));
    }
  }
}
