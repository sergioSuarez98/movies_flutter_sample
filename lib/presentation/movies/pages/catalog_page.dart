import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponor_technical_test/helpers/service_locator.dart';
import 'package:uponor_technical_test/presentation/movies/cubit/movie_cubit.dart';
import 'package:uponor_technical_test/presentation/movies/pages/moview_form_page.dart';
import 'package:uponor_technical_test/presentation/movies/widgets/movie_card.dart';

class CatalogView extends StatefulWidget {
  @override
  State<CatalogView> createState() => _CatalogViewState();
}

class _CatalogViewState extends State<CatalogView> {
  //para que solo aparezca el icono de borrar al activarlo en el app bar.
  bool deleteAllowed = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<MovieCubit>()..fetchMovies(), //carga inicial de películas
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Uponorflix'),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    deleteAllowed = !deleteAllowed;
                  });
                },
                child: const Icon(
                  Icons.delete,
                ),
              ),
            )
          ],
        ),
        body: BlocConsumer<MovieCubit, MovieState>(
          listener: (context, state) {
            if (state is MovieError) {
              //mensajes informativos en función de los estados
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
            if (state is DeleteMovieSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Movie deleted successfully!'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is MovieLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieSuccess) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                //Utilizado grid view para mostrar un diseño algo más completo
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: state.catalog.length,
                  itemBuilder: (context, index) {
                    final movie = state.catalog[index];
                    return MovieCard(
                      movie: movie,

                      ///se le pasa el deletedAllowed para que cada card
                      ///tenga su botón
                      deleteAllowed: deleteAllowed,
                      deletedTap: () async {
                        await context
                            .read<MovieCubit>()
                            .deleteExistingMovie(movie);
                      },
                    );
                  },
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.push(
              context,
              MovieFormPage.route(null),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
