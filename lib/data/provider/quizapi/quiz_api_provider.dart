import 'dart:convert';
import 'package:flutter_architecture/data/models/question.dart';
import 'package:flutter_architecture/data/provider/quizapi/mapper/question_mapper.dart';
import 'dto/question_dto.dart';
import 'package:http/http.dart' as http;

abstract class QuizApiProviderInterface {
  Future<List<Question>> getQuestions({required int numQuestions, required int categoryId});
  void dispose();
}

class QuizApiProvider extends QuizApiProviderInterface {
  String endpoint = "opentdb.com";
  final _httpClient = http.Client();

  @override
  Future<List<Question>> getQuestions({required int numQuestions, required int categoryId}) async {
    final queryParameters = {
      "type": "multiple",
      "amount": numQuestions,
      "category": categoryId
    };
    final uri = Uri.https(endpoint, "api.php", queryParameters);
    final response = await _httpClient.get(uri);

    if (response.statusCode != 200) throw http.ClientException('Failed to load quiz with params $queryParameters');

    return (json.decode(response.body)["results"] as List)
        .map((e) => QuestionDto.fromJson(e))
        .map((e) => QuestionMapper.map(e)).toList();
  }

  @override
  void dispose() {
    _httpClient.close();
  }
}