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
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
  }

  Future<Response> registerUser(Map<String, dynamic> data) async {
    try {
      return await _dio.post('users/register/', data: data);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<Response> loginUser(Map<String, dynamic> data) async {
    try {
      return await _dio.post('users/login/', data: data);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<Response> getUserDetails(int userId, String accessToken) async {
    try {
      print(
          'Requesting user details for userId: $userId with token: $accessToken');
      final response = await _dio.get(
        'users/user/$userId/',
        options: Options(
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      print('Response received: ${response.data}');
      return response;
    } on DioException catch (e) {
      print('Error occurred: ${e.response?.data ?? e.message}');
      return e.response ?? Response(requestOptions: RequestOptions(path: ''));
    } catch (e) {
      print('Unexpected error: $e');
      return Response(requestOptions: RequestOptions(path: ''));
    }
  }

  Response _handleError(dynamic e) {
    if (e is DioException) {
      print('DioError: ${e.message}');
      if (e.response != null) {
        print('Response data: ${e.response?.data}');
        return e.response!;
      } else {
        return Response(requestOptions: RequestOptions(path: ''));
      }
    } else {
      print('Unexpected error: $e');
      return Response(requestOptions: RequestOptions(path: ''));
    }
  }
}
