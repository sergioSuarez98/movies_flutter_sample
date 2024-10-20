// ignore_for_file: sort_constructors_first

part of 'movie_cubit.dart';

abstract class MovieState extends Equatable {
  const MovieState();
}

class MovieInitial extends MovieState {
  @override
  List<Object?> get props => [];
}

class MovieLoading extends MovieState {
  @override
  List<Object?> get props => [];
}

class MovieSuccess extends MovieState {
  final List<Movie> catalog;
  const MovieSuccess(this.catalog);

  @override
  List<Object?> get props => [];
}

class AddMovieSuccess extends MovieState {
  @override
  List<Object?> get props => [];
}

class UpdateMovieSuccess extends MovieState {
  @override
  List<Object?> get props => [];
}

class MovieError extends MovieState {
  final String message;
  const MovieError(this.message);

  @override
  List<Object?> get props => [];
}
