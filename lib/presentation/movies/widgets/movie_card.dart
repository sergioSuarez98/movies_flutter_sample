import 'package:flutter/material.dart';
import 'package:uponor_technical_test/domain/entities/movie.dart';
import 'package:uponor_technical_test/presentation/movies/pages/moview_form_page.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;
  bool deleteAllowed;
  final Function() deletedTap;

  MovieCard(
      {Key? key,
      required this.movie,
      required this.deleteAllowed,
      required this.deletedTap})
      : super(key: key);

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ///para que cuando estemos borrando películas, no podamos
        ///pulsar en el cartel y que te navege a la pantalla de editar.
        !widget.deleteAllowed
            ? Navigator.push(context, MovieFormPage.route(widget.movie))
            : () {};
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                widget.movie.posterUrl,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,

                ///esto está puesto por que si se compila en web hay
                ///un conflicto al cargar las network images que vienen
                ///de una url. Así por lo menos aparece una carátula y la usabilidad se
                ///puede comprobar
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Image.asset('assets/images/default_poster.png');
                },
              ),
            ),
            widget.deleteAllowed
                ? Positioned(
                    right: 5,
                    top: 5,
                    child: GestureDetector(
                      onTap: widget.deletedTap,
                      child: const Icon(
                        Icons.cancel_outlined,
                        color: Colors.red,
                      ),
                    ),
                  )
                : const SizedBox(),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.movie.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Rating: ${widget.movie.rating}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${widget.movie.releaseYear}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
