import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:uponor_technical_test/data/models/movie_model.dart';
import 'package:uponor_technical_test/domain/entities/movie.dart';
import 'package:uponor_technical_test/helpers/movies_mock.dart';
import 'package:uponor_technical_test/helpers/service_locator.dart';
import 'package:uponor_technical_test/presentation/movies/cubit/movie_cubit.dart';
import 'package:uponor_technical_test/presentation/movies/widgets/movie_card.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getMovies();
  Future<void> addMovie(Movie newMovie);
  Future<Movie> updateMovie(Movie updatedMovie);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final Dio dio;

  MovieRemoteDataSourceImpl(this.dio) {
    dio.interceptors.add(MockInterceptor());
  }
  var movieList = <MovieModel>[];
  @override
  Future<List<MovieModel>> getMovies() async {
    final response = await dio.get('https://example.com/movies');
    if (response.statusCode == 200) {
      movieList = (jsonDecode(response.data) as List)
          .map((movieJson) => MovieModel.fromJson(movieJson))
          .toList();
      return movieList;
    } else {
      throw Exception('Error al cargar películas');
    }
  }

  @override
  Future<void> addMovie(Movie newMovie) async {
    final response = await dio.post(
      'https://example.com/movies',
      data: newMovie.toJson(),
    );
    if (response.statusCode == 201) {
      print('success');
    } else {
      throw Exception('Error al agregar película');
    }
  }

  @override
  Future<Movie> updateMovie(Movie updatedMovie) async {
    final response = await dio.put(
      'https://example.com/movies/${updatedMovie.id}',
      data: updatedMovie.toJson(),
    );
    if (response.statusCode == 200) {
      print(response.data);
      final movieJson = jsonDecode(response.data);
      final movie = MovieModel.fromJson(movieJson);
      return movie;
    } else {
      throw Exception('Error al agregar película');
    }
  }
}
