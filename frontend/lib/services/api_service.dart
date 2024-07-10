import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'token_storage.dart';

class ApiService {
  late final Dio _dio;
  final String _baseUrl = 'http://192.168.100.92:8000/api/';
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

  Future<Map<String, dynamic>?> registerAndLoginUser(Map<String, dynamic> registrationData) async {
    try {
      final registerResponse = await registerUser(registrationData);
      print('Register response: ${registerResponse.data}');
      if (registerResponse.statusCode == 200 || registerResponse.statusCode == 201) {
        final loginData = {
          'username': registrationData['email'],
          'password': registrationData['password'],
        };
        final loginResponse = await loginUser(loginData);
        print('Login response: ${loginResponse.data}');
        if (loginResponse.statusCode == 200) {
          final tokens = loginResponse.data;
          await tokenStorage.saveTokens(tokens['access'], tokens['refresh']);
          final userId = tokens['user_id'];
          if (userId != null) {
            final userDetailsResponse = await getUserDetails(userId, tokens['access']);
            print('User details response: ${userDetailsResponse.data}');
            if (userDetailsResponse.statusCode == 200) {
              await tokenStorage.saveUserData(userDetailsResponse.data);
              return userDetailsResponse.data;
            } else {
              print('Fetching user details failed: ${userDetailsResponse.data}');
              return null;
            }
          } else {
            print('User ID is null in login response');
            return null;
          }
        } else {
          print('Login failed after registration: ${loginResponse.data}');
          return null;
        }
      } else {
        print('Registration failed: ${registerResponse.data}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<Response> getUserDetails(int userId, String accessToken) async {
    try {
      print('Requesting user details for userId: $userId with token: $accessToken');
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

  Future<List<dynamic>?> getCompanions() async {
  try {
    final response = await _dio.get(
      'companion/companions/',
    
    );
    if (response.statusCode == 200) {
      return response.data;
    } else {
      print('Failed to fetch companions: ${response.data}');
      return null;
    }
  } catch (e) {
    print('Error fetching companions: $e');
    return null;
  }
} 

 
  Future<Response> uploadFile(FormData formData) async {
    try {
      return await _dio.post('files/upload/', data: formData);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<Response> bookCompanion(FormData bookingData) async {
    try {
      return await _dio.post('booking/bookings/', data: bookingData);
    } catch (e) {
      return _handleError(e);
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
