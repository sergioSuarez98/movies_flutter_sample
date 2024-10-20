import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:uponor_technical_test/data/datasources/movie_remote_data_source.dart';
import 'package:uponor_technical_test/data/repository/movie_repository_impl.dart';
import 'package:uponor_technical_test/domain/repositories/movie_repository.dart';
import 'package:uponor_technical_test/domain/usecases/add_movie.dart';
import 'package:uponor_technical_test/domain/usecases/delete_movie.dart';
import 'package:uponor_technical_test/domain/usecases/get_movies.dart';
import 'package:uponor_technical_test/domain/usecases/update_movie.dart';
import 'package:uponor_technical_test/presentation/movies/cubit/movie_cubit.dart';

final getIt = GetIt.instance;

//clase de inyección de dependencias, para no tener que escribir todo en el main.
class ServiceLocator {
  static void setupDependencies() {
    getIt.registerLazySingleton<Dio>(() => Dio());

    // DI  Remote Data Source
    getIt.registerLazySingleton<MovieRemoteDataSource>(
        () => MovieRemoteDataSourceImpl(getIt<Dio>()));

    // DI repository
    getIt.registerLazySingleton<MovieRepository>(
        () => MovieRepositoryImpl(getIt<MovieRemoteDataSource>()));

    // DI Use Case
    getIt.registerLazySingleton<GetMovies>(
        () => GetMovies(getIt<MovieRepository>()));
    getIt.registerLazySingleton<AddMovie>(
        () => AddMovie(getIt<MovieRepository>()));
    getIt.registerLazySingleton<UpdateMovie>(
        () => UpdateMovie(getIt<MovieRepository>()));
    getIt.registerLazySingleton<DeleteMovie>(
        () => DeleteMovie(getIt<MovieRepository>()));
    // DI Cubit
    getIt.registerFactory<MovieCubit>(() => MovieCubit(getIt<GetMovies>(),
        getIt<AddMovie>(), getIt<UpdateMovie>(), getIt<DeleteMovie>()));
  }
}
