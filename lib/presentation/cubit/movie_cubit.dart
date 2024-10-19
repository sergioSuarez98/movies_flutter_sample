// ignore_for_file: lines_longer_than_80_chars
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uponor_technical_test/domain/entities/movie.dart';
import 'package:uponor_technical_test/domain/usecases/get_movies.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final GetMovies getMovies;
  MovieCubit(this.getMovies) : super(MovieInitial());

  Future<void> fetchMovies() async {
    emit(MovieLoading());
    await Future.delayed(const Duration(seconds: 2));
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
}
