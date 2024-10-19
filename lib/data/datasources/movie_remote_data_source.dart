import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:uponor_technical_test/data/models/movie_model.dart';
import 'package:uponor_technical_test/helpers/movies_mock.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getMovies();
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final Dio dio;

  MovieRemoteDataSourceImpl(this.dio) {
    dio.interceptors.add(MockInterceptor());
  }

  @override
  Future<List<MovieModel>> getMovies() async {
    final response = await dio.get('https://example.com/movies');
    if (response.statusCode == 200) {
      print('El mock llega correctamente');
      return (jsonDecode(response.data) as List)
          .map((movieJson) => MovieModel.fromJson(movieJson))
          .toList();
    } else {
      throw Exception('Error al cargar películas');
    }
  }
}
