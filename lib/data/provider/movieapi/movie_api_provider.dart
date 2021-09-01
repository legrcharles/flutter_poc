import 'package:flutter_architecture/core/network/http_client.dart';
import 'package:flutter_architecture/data/models/movie.dart';
import 'package:flutter_architecture/data/provider/movieapi/dto/movie_dto.dart';
import 'package:flutter_architecture/data/provider/movieapi/dto/movie_request_dto.dart';
import 'package:flutter_architecture/data/provider/movieapi/mapper/movie_mapper.dart';

abstract class MovieApiProviderInterface {
  Future<List<Movie>> getMovies({required String query});
}

class MovieApiProvider extends MovieApiProviderInterface {
  final HttpClient _httpClient;

  MovieApiProvider(this._httpClient);

  @override
  Future<List<Movie>> getMovies({required String query}) {
    final apiKey = "f9bed01b";

    Map<String, dynamic> queryParameters =
        MovieRequestDto(apiKey: apiKey, query: query).toJson();

    return _httpClient
        .request("", queryParameters, null)
        .then((value) {
      final results = List<Map<String, dynamic>>.from(value['Search']);
      final dtos = results.map((e) => MovieDto.fromJson(e)).toList();
      return dtos.map((e) => MovieMapper.map(e)).toList();
    });
  }
}