import 'package:dio/dio.dart';
import 'dart:convert';

class MockInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path == 'https://example.com/movies') {
      //mock response
      final mockResponse = jsonEncode([
        {
          "id": "1",
          "title": "Inception",
          "description":
              "A skilled thief is offered a chance to have his criminal history erased if he can successfully implant an idea into a target's subconscious.",
          "releaseYear": 2010,
          "genre": ["Action", "Sci-Fi", "Thriller"],
          "rating": 8.8,
          "posterUrl":
              "https://posters.movieposterdb.com/10_06/2010/1375666/l_1375666_ea0f4fc9.jpg"
        },
        {
          "id": "2",
          "title": "The Matrix",
          "description":
              "A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.",
          "releaseYear": 1999,
          "genre": ["Action", "Sci-Fi"],
          "rating": 8.7,
          "posterUrl":
              "https://posters.movieposterdb.com/06_01/1999/0133093/s_77607_0133093_ab8bc972.jpg"
        },
        {
          "id": "3",
          "title": "Interstellar",
          "description":
              "A team of explorers travel through a wormhole in space in an attempt to ensure humanity's survival.",
          "releaseYear": 2014,
          "genre": ["Adventure", "Drama", "Sci-Fi"],
          "rating": 8.6,
          "posterUrl":
              "https://posters.movieposterdb.com/14_09/2014/816692/s_816692_593eaeff.jpg"
        },
        {
          "id": "4",
          "title": "The Shawshank Redemption",
          "description":
              "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.",
          "releaseYear": 1994,
          "genre": ["Drama"],
          "rating": 9.3,
          "posterUrl":
              "https://posters.movieposterdb.com/05_03/1994/0111161/s_8494_0111161_3bb8e662.jpg"
        },
        {
          "id": "5",
          "title": "The Dark Knight",
          "description":
              "When the menace known as the Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham.",
          "releaseYear": 2008,
          "genre": ["Action", "Crime", "Drama"],
          "rating": 9.0,
          "posterUrl":
              "https://posters.movieposterdb.com/08_05/2008/468569/l_468569_f0e2cd63.jpg"
        },
        {
          "id": "8",
          "title": "Avengers: Infinity War",
          "description":
              "The Avengers and their allies must be willing to sacrifice all in an attempt to defeat the powerful Thanos before his blitz of devastation and ruin puts an end to the universe.",
          "releaseYear": 2018,
          "genre": ["Acción", "Aventura", "Sci-Fi"],
          "rating": 8.8,
          "posterUrl":
              "https://posters.movieposterdb.com/21_08/2018/4154756/s_4154756_422c1e98.jpg"
        },
      ]);

      //simulated response
      final response = Response(
        requestOptions: options,
        data: mockResponse,
        statusCode: 200,
      );
      handler.resolve(response);
    } else {
      super.onRequest(options, handler);
    }
  }
}
