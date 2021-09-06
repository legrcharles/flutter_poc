import 'dart:convert';
import 'package:flutter_architecture/data/models/movie.dart';
import 'package:flutter_architecture/data/provider/movieapi/dto/movie_dto.dart';
import 'package:flutter_architecture/data/provider/movieapi/mapper/movie_mapper.dart';
import 'package:http/http.dart' as http;

abstract class MovieApiProviderInterface {
  Future<List<Movie>> getMovies({required String query});
  void dispose();
}

class MovieApiProvider extends MovieApiProviderInterface {
  final String _endpoint;
  final http.Client _httpClient;

  MovieApiProvider(this._endpoint, this._httpClient);

  @override
  Future<List<Movie>> getMovies({required String query}) async {
    final queryParameters = {
      "apikey": "f9bed01b",
      "s": query
    };
    final uri = Uri.http(_endpoint, "", queryParameters);
    final response = await _httpClient.get(uri);

    if (response.statusCode != 200) throw http.ClientException('Failed to load movies with query $query');

    /*
    return (json.decode(response.body)["Search"] as List)
        .map((e) => MovieDto.fromJson(e))
        .map((e) => MovieMapper.map(e)).toList();

     */

    return MovieResponseDto.fromJson(json.decode(response.body))
        .movies
        .map((e) => MovieMapper.map(e)).toList();
  }

  @override
  void dispose() {
    _httpClient.close();
  }
}