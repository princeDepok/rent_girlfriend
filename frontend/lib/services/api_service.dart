import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'token_storage.dart';

class ApiService {
  late final Dio _dio;
  final String _baseUrl = 'http://10.10.154.48:8000/api/';
  final TokenStorage tokenStorage = TokenStorage();

  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
    ));
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
    ));
  }

  Future<Response> registerUser(Map<String, dynamic> data) async {
    return await _dio.post('users/register/', data: data);
  }

  Future<Response> loginUser(Map<String, dynamic> data) async {
    return await _dio.post('users/login/', data: data);
  }

  Future<Response> getUserDetails(int userId, String accessToken) async {
    return await _dio.get(
      'users/user/$userId/',
      options: Options(
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
  }
}
