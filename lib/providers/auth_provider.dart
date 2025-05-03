import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tasksphere_riverpod/models/login_model.dart';
import 'package:tasksphere_riverpod/models/signup_model.dart';
import 'package:tasksphere_riverpod/models/user_model.dart';
import 'package:tasksphere_riverpod/services/auth_service.dart';

part 'auth_provider.g.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

@riverpod
class AuthController extends _$AuthController {
  late FlutterSecureStorage _storage;
  late AuthService _authService;
  @override
  Future<User?> build() async {
    // Initialize any state or perform setup here
    _storage = ref.read(secureStorageProvider);
    _authService = ref.read(authServiceProvider);

    // Check for existing user on app start
    return await getStoredUser();
  }

  Future<User?> getStoredUser() async {
    // Return the already loaded user from state if available
    if (state is AsyncData<User?>) {
      return state.value;
    }

    final userData = await _storage.read(key: 'user');
    return userData != null ? User.fromJson(json.decode(userData)) : null;
  }

  Future<void> _persistUser(User user) async {
    await _storage.write(key: 'user', value: json.encode(user.toJson()));
  }

  Future<void> _clearUser() async {
    await _storage.delete(key: 'user');
  }

  Future<void> register(Register registerData) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = await _authService.register(registerData);
      await _persistUser(user);
      return user;
    });
  }

  Future<void> login(Login loginData) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = await _authService.login(loginData);
      await _persistUser(user);
      return user;
    });
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _authService.logout();
      await _clearUser();
      return null;
    });
  }
}
