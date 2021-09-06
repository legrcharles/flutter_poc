import 'dart:convert';
import 'dart:developer';
import 'package:flutter_architecture/data/models/question.dart';
import 'package:flutter_architecture/data/provider/quizapi/mapper/question_mapper.dart';
import 'dto/question_dto.dart';
import 'package:http/http.dart' as http;

abstract class QuizApiProviderInterface {
  Future<List<Question>> getQuestions({required int numQuestions, required int categoryId});
  void dispose();
}

class QuizApiProvider extends QuizApiProviderInterface {
  final String _endpoint;
  final http.Client _httpClient;

  QuizApiProvider(this._endpoint, this._httpClient);

  @override
  Future<List<Question>> getQuestions({required int numQuestions, required int categoryId}) async {
    final queryParameters = {
      "type": "multiple",
      "amount": numQuestions.toString(),
      "category": categoryId.toString()
    };

    final uri = Uri.https(_endpoint, "/api.php", queryParameters);
    log(uri.toString());
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