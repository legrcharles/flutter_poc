import 'package:flutter_architecture/core/network/http_client.dart';
import 'package:flutter_architecture/data/models/question.dart';
import 'package:flutter_architecture/data/provider/quizapi/dto/question_request_dto.dart';
import 'package:flutter_architecture/data/provider/quizapi/mapper/question_mapper.dart';
import 'dto/question_dto.dart';

abstract class QuizApiProviderInterface {
  Future<List<Question>> getQuestions({required int numQuestions, required int categoryId});
}

class QuizApiProvider extends QuizApiProviderInterface {
  final HttpClient _httpClient;

  QuizApiProvider(this._httpClient);

  @override
  Future<List<Question>> getQuestions({required int numQuestions, required int categoryId}) {
    Map<String, dynamic> queryParameters =
      QuestionRequestDto(type: 'multiple',
          amount: numQuestions,
          category: categoryId)
        .toJson();

    return _httpClient
        .request("api.php", queryParameters, null)
        .then((value) {
          final results = List<Map<String, dynamic>>.from(value['results']);
          final dtos = results.map((e) => QuestionDto.fromJson(e)).toList();
          return dtos.map((e) => QuestionMapper.map(e)).toList();
        });
  }
}