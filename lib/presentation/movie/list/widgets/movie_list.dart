import 'package:flutter/material.dart';
import 'package:flutter_architecture/data/models/movie.dart';
import 'package:flutter_architecture/presentation/movie/list/widgets/movie_list_item.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MovieListItem(movie: movie);
      },
    );
  }
}
