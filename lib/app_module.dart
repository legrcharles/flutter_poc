import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'core/network/http_client.dart';
import 'data/provider/quizapi/quiz_api_provider.dart';

final baseHttpClient = HttpClient("https://opentdb.com");

final quizApiProvider =
  Provider<QuizApiProviderInterface>((ref)=> QuizApiProvider(baseHttpClient));

final dataManager =
  Provider<DataManager>((ref) => DataManager(ref.read(quizApiProvider)));