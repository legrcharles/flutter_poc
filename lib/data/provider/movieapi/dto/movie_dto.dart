class MovieDto {

  final String title;
  final String poster;

  MovieDto({required this.title, required this.poster});

  factory MovieDto.fromJson(Map<String, dynamic> json) {
    return MovieDto(
        title: json["Title"],
        poster: json["Poster"]
    );
  }

}