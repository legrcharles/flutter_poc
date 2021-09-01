class MovieDto {

  final String title;
  final String poster;

  MovieDto({required this.title, required this.poster});

  MovieDto.fromJson(Map<String, dynamic> json)
      : title = json["Title"],
        poster = json["Poster"];

  Map<String, dynamic> toJson() => {
    'Title': title,
    'Poster': poster,
  };
}

class MovieResponseDto {
  final List<MovieDto> movies;

  MovieResponseDto(this.movies);

  MovieResponseDto.fromJson(Map<String, dynamic> json)
      : movies = (json["Search"] as List).map((e) => MovieDto.fromJson(e)).toList();
}