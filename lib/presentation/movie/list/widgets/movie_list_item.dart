import 'package:flutter/material.dart';
import 'package:flutter_architecture/data/models/movie.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieListItem extends StatelessWidget {
  const MovieListItem({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 60,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(movie.poster)
                  ),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(4), topLeft: Radius.circular(4))
              ),
              width: 50,

            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(movie.title,
                  style: GoogleFonts.aleo(fontStyle: FontStyle.normal, fontSize: 14))
            )
          ],
        ),
      )
    );
  }

  Widget test() {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        leading: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(movie.poster)
              ),
              borderRadius: BorderRadius.circular(6)
          ),
          width: 50,
          height: 100,
        ),
        title: Text(movie.title),
      ),
    );
  }
}
