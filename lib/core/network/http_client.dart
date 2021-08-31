import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import '../error/failure.dart';

class HttpClient {

  String baseUrl;

  HttpClient(this.baseUrl);

  Future<Map<String, dynamic>> request(String endpoint, Map<String, dynamic>? queryParameters, Options? options) async {
    // Appel WS
    try {

      final url = '$baseUrl/$endpoint';

      log('test $url');
      log('queryParameters $queryParameters');

      final response = await Dio().get(url, queryParameters: queryParameters, options: options);

      // Récupérer réponse
      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(response.data);
        return data;
      } else {
        throw Failure(message: 'Please check your connection.');
      }
    } on DioError catch (err) {
      print(err);
      throw Failure(
          message: err.response?.statusMessage ?? 'Something went wrong!');
    } on SocketException catch (err) {
      print(err);
      throw Failure(message: 'Please check your connection.');
    }
  }
}