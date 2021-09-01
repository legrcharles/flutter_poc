import 'package:equatable/equatable.dart';

class MovieRequestDto extends Equatable {
  final String apiKey;
  final String query;

  const MovieRequestDto(
      {required this.apiKey, required this.query});

  @override
  List<Object> get props => [query, apiKey];

  Map<String, dynamic> toJson() {
    final queryParameters = {
      'apikey': apiKey,
      's': query
    };
    return queryParameters;
  }
}
