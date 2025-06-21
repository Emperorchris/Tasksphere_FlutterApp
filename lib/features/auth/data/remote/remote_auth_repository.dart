import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tasksphere_riverpod/common/exceptions/exceptions.dart';
import 'package:tasksphere_riverpod/features/auth/data/dto/login_response_dto.dart';
import 'package:tasksphere_riverpod/features/auth/domain/auth_repository.dart';

class RemoteAuthRepository implements AuthRepository {
  final Dio _dio;
  RemoteAuthRepository(this._dio);
  @override
  Future<String?> getCurrentUserId() {
    // TODO: implement getCurrentUserId
    throw UnimplementedError();
  }

  @override
  Future<bool> isSignedIn() {
    // TODO: implement isSignedIn
    throw UnimplementedError();
  }

  @override
  Future<LoginResponse> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/login',
        data: {'email': email, 'password': password},
      );
        debugPrint("From AuthRepository signInWithEmailAndPassword");
      final dto = LoginResponseDto.fromJson(response.data);

      return LoginResponse(userId: dto.data.id, token: dto.token);
    } on DioException catch (e) {
      throw AuthException(
        e.response?.data['message'] ??
            e.response?.data['error'] ??
            "An error occurred during sign-in",
      );
    } catch (e) {
      throw AuthException("An unexpected error occurred: $e");
    }
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<SignUpResponse> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String confirmPassword,
    required String username,
  }) {
    // TODO: implement signUpWithEmailAndPassword
    throw UnimplementedError();
  }
}
