import 'package:flutter_architecture/data/models/movie.dart';
import 'package:flutter_architecture/data/provider/movieapi/dto/movie_dto.dart';

class MovieMapper {

  static Movie map(MovieDto dto) {
    return Movie(title: dto.title, poster: dto.poster);
  }
}