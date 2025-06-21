import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasksphere_riverpod/common/providers/dio_provider.dart';
import 'package:tasksphere_riverpod/features/auth/data/remote/remote_auth_repository.dart';


final authRespositoryProvider = Provider<AuthRepository>((ref) {
  return RemoteAuthRepository(ref.read(dioProvider));
});

abstract class AuthRepository {
  Future<LoginResponse> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<SignUpResponse> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String confirmPassword,
    required String username,
  });

  Future<void> signOut();

  Future<bool> isSignedIn();

  Future<String?> getCurrentUserId();
}

class SignUpResponse {
  final String userId;
  final String token;
  SignUpResponse({required this.userId, required this.token});
}

class LoginResponse {
  final String? userId;
  final String? token;
  LoginResponse({this.userId, this.token});
}
