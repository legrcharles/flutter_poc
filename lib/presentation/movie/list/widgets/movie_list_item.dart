import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/data/models/movie.dart';
import 'package:flutter_architecture/presentation/common/utils/color_utils.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieListItem extends StatelessWidget {
  const MovieListItem({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: Platform.isIOS ? 0 : 1,
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(movie.poster)
                  ),
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(4), topLeft: Radius.circular(4))
              ),
              width: 50,

            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(movie.title,
                  style: Theme.of(context).textTheme.bodyText2)
            )
          ],
        ),
      )
    );
  }
}
