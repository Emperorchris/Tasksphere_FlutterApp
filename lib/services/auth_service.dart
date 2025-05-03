import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tasksphere_riverpod/models/login_model.dart';
import 'package:tasksphere_riverpod/models/signup_model.dart';
import 'package:tasksphere_riverpod/models/user_model.dart';
import 'package:tasksphere_riverpod/providers/dio_provider.dart';

part 'auth_service.g.dart';

@riverpod
AuthService authService(Ref ref) {
  final dio = ref.watch(dioProvider);
  return AuthService(dio);
}

class AuthService {
  final Dio _dio;
  AuthService(this._dio);

  Future<User> register(Register register) async {
    try {
      final response = await _dio.post('/register', data: register.toJson());
      final user = _handleAuthResponse(response);

      _dio.options.headers["Authorization"] = "Bearer ${user.token}";

      return user;
    } on DioException catch (e) {
      throw _parseError(e);
    }
  }

  Future<User> login(Login data) async {
    try {
      final response = await _dio.post('/login', data: data.toJson());
      final user = _handleAuthResponse(response);

      // After successful register, set the Authorization header
      _dio.options.headers["Authorization"] = "Bearer ${user.token}";

      return user;
    } on DioException catch (e) {
      throw _parseError(e);
    }
  }

  Future<void> logout() async {
    try {
      await _dio.post('/logout');
    } on DioException catch (e) {
      throw _parseError(e);
    }
  }

  User _handleAuthResponse(Response response) {
    print(response.data);

    // if (response.statusCode == 401) {
    //   throw Exception('Unauthorized');
    // }
    if (response.statusCode == 200 || response.statusCode == 201) {
      return User.fromJson(response.data);
    }
    throw Exception('Unexpected response status: ${response.statusCode}');
  }

  Exception _parseError(DioException e) {
    print(e.response);
    return Exception(
      e.response?.data['message'] ??
          e.response?.data['error'] ??
          e.message ??
          e.error ??
          'Unknown error occurred',
    );
  }
}
