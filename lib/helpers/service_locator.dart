import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:uponor_technical_test/data/datasources/movie_remote_data_source.dart';
import 'package:uponor_technical_test/data/repository/movie_repository_impl.dart';
import 'package:uponor_technical_test/domain/repositories/movie_repository.dart';
import 'package:uponor_technical_test/domain/usecases/get_movies.dart';
import 'package:uponor_technical_test/presentation/cubit/movie_cubit.dart';

final getIt = GetIt.instance;

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

    // DI Cubit
    getIt.registerFactory<MovieCubit>(() => MovieCubit(getIt<GetMovies>()));
  }
}
