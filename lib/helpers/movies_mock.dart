import 'package:dio/dio.dart';
import 'dart:convert';

class MockInterceptor extends Interceptor {
  //esto  simula al json con el listado de películas que se recibiría de backend
  List<Map<String, dynamic>> movies = [
    {
      "id": "1",
      "title": "Inception",
      "releaseYear": 2010,
      "rating": 8.8,
      "posterUrl":
          "https://posters.movieposterdb.com/10_06/2010/1375666/l_1375666_ea0f4fc9.jpg"
    },
    {
      "id": "2",
      "title": "The Matrix",
      "releaseYear": 1999,
      "rating": 8.7,
      "posterUrl":
          "https://posters.movieposterdb.com/06_01/1999/0133093/s_77607_0133093_ab8bc972.jpg"
    },
    {
      "id": "3",
      "title": "Interstellar",
      "releaseYear": 2014,
      "rating": 8.6,
      "posterUrl":
          "https://posters.movieposterdb.com/14_09/2014/816692/s_816692_593eaeff.jpg"
    },
    {
      "id": "4",
      "title": "The Shawshank Redemption",
      "releaseYear": 1994,
      "rating": 9.3,
      "posterUrl":
          "https://posters.movieposterdb.com/05_03/1994/0111161/s_8494_0111161_3bb8e662.jpg"
    },
    {
      "id": "5",
      "title": "The Dark Knight",
      "releaseYear": 2008,
      "rating": 9.0,
      "posterUrl":
          "https://posters.movieposterdb.com/08_05/2008/468569/l_468569_f0e2cd63.jpg"
    },
    {
      "id": "8",
      "title": "Avengers: Infinity War",
      "releaseYear": 2018,
      "rating": 8.8,
      "posterUrl":
          "https://posters.movieposterdb.com/21_08/2018/4154756/s_4154756_422c1e98.jpg"
    },
  ];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path == 'https://example.com/movies') {
      //aquí se puede ver que las respuestas las doy en función de que tipo de petición sea.
      if (options.method == 'GET') {
        final response = Response(
          requestOptions: options,
          data: jsonEncode(movies),
          statusCode: 200,
        );
        handler.resolve(response);
      } else if (options.method == 'POST') {
        final jsonString = jsonEncode(options.data);
        final newMovie = jsonDecode(jsonString);
        //para que el id siempre siga en aumento
        newMovie['id'] = (movies.length + 1).toString();
        movies.add(newMovie);

        final response = Response(
          requestOptions: options,
          data: jsonEncode(movies),
          statusCode: 201,
        );
        handler.resolve(response);
      }
    } else if (options.path.startsWith('https://example.com/movies/')) {
      //para simular como se haría en un put y delete normales, pasando el id por la url en este caso.
      final movieId = options.path.split('/').last;

      if (options.method == 'PUT') {
        final jsonString = jsonEncode(options.data);
        final updatedMovie = jsonDecode(jsonString);
        //busca por id para modificar ese objeto
        final index = movies.indexWhere((movie) => movie['id'] == movieId);

        if (index != -1) {
          movies[index] = updatedMovie;
          final response = Response(
            requestOptions: options,
            data: jsonEncode(updatedMovie),
            statusCode: 200,
          );
          handler.resolve(response);
        } else {
          handler.reject(DioException(
            requestOptions: options,
            response: Response(requestOptions: options, statusCode: 404),
          ));
        }
      } else if (options.method == 'DELETE') {
        //también busca por id para borrar
        final index = movies.indexWhere((movie) => movie['id'] == movieId);

        if (index != -1) {
          movies.removeAt(index);
          final response = Response(
            requestOptions: options,
            statusCode: 204,
          );
          handler.resolve(response);
        } else {
          handler.reject(
            DioException(
              requestOptions: options,
              response: Response(requestOptions: options, statusCode: 404),
            ),
          );
        }
      }
    } else {
      super.onRequest(options, handler);
    }
  }
}
