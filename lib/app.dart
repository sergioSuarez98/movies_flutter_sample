import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponor_technical_test/helpers/service_locator.dart';
import 'package:uponor_technical_test/presentation/movies/cubit/movie_cubit.dart';
import 'package:uponor_technical_test/presentation/movies/pages/catalog_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uponor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => getIt<MovieCubit>(),
        child: CatalogView(),
      ),
    );
  }
}
