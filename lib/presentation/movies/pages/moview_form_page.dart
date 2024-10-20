import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uponor_technical_test/domain/entities/movie.dart';
import 'package:uponor_technical_test/domain/usecases/add_movie.dart';
import 'package:uponor_technical_test/domain/usecases/get_movies.dart';
import 'package:uponor_technical_test/helpers/service_locator.dart';
import 'package:uponor_technical_test/helpers/validators.dart';
import 'package:uponor_technical_test/presentation/movies/cubit/movie_cubit.dart';
import 'package:uponor_technical_test/presentation/movies/pages/catalog_page.dart';
import 'package:uponor_technical_test/presentation/movies/widgets/form_text_form_field.dart';

class MovieFormPage extends StatelessWidget {
  final Movie? movie;

  const MovieFormPage({Key? key, this.movie}) : super(key: key);
  static Route route(Movie? movie) {
    return MaterialPageRoute<void>(builder: (_) => MovieFormPage(movie: movie));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MovieCubit>(),
      child: _MovieFormPage(movie: movie),
    );
  }
}

class _MovieFormPage extends StatefulWidget {
  final Movie? movie;

  const _MovieFormPage({Key? key, this.movie}) : super(key: key);

  @override
  State<_MovieFormPage> createState() => _MovieFormPageState();
}

class _MovieFormPageState extends State<_MovieFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String title = '';
  String releaseYear = '';
  String rating = '';
  TextEditingController titleController = TextEditingController();
  TextEditingController releaseYearController = TextEditingController();
  TextEditingController ratingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.movie != null) {
      title = widget.movie!.title;
      releaseYear = widget.movie!.releaseYear.toString();
      rating = widget.movie!.rating.toString();
      titleController.text = title;
      releaseYearController.text = releaseYear;
      ratingController.text = rating;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.movie == null ? 'Add Movie' : widget.movie!.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocConsumer<MovieCubit, MovieState>(
            listener: (context, state) async {
              if (state is AddMovieSuccess || state is UpdateMovieSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Movie added successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => CatalogView()),
                  (Route<dynamic> route) => false,
                );
              } else if (state is MovieError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error: ${state.message}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is MovieLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    FormTextFormField(
                      initialValue: title,
                      labelText: 'Title',
                      validator: (value) => Validators.titleValidator(value),
                      inputType: TextInputType.text,
                      controller: titleController,
                    ),
                    FormTextFormField(
                      initialValue: releaseYear,
                      labelText: 'Release year',
                      validator: (value) =>
                          Validators.releaseYearValidator(value),
                      inputType: TextInputType.number,
                      controller: releaseYearController,
                    ),
                    FormTextFormField(
                      initialValue: rating,
                      labelText: 'Rating',
                      validator: (value) => Validators.ratingValidotor(value),
                      inputType: TextInputType.number,
                      controller: ratingController,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _saveForm,
                      child: Text(widget.movie == null ? 'Save' : 'Edit'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final movieCubit = context.read<MovieCubit>();
      if (widget.movie == null) {
        movieCubit.addNewMovie(
          Movie(
            id: '',
            title: titleController.text,
            releaseYear: int.parse(releaseYearController.text),
            rating: double.parse(ratingController.text),
            posterUrl:
                'https://posters.movieposterdb.com/11_03/2011/944947/s_944947_390180e8.jpg',
          ),
        );
      } else {
        movieCubit.updateExistingMovie(
          Movie(
            id: widget.movie!.id,
            title: titleController.text,
            releaseYear: int.parse(releaseYearController.text),
            rating: double.parse(ratingController.text),
            posterUrl: widget.movie!.posterUrl,
          ),
        );
      }
    }
  }
}
