import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasksphere_riverpod/common/repositories/storage_repository_provider.dart';
import 'package:tasksphere_riverpod/features/auth/domain/auth_model.dart';
import 'package:tasksphere_riverpod/features/auth/domain/auth_repository.dart';

final authServicesProvider =
    AsyncNotifierProvider<AuthServicesNotifier, AuthModel>(
      AuthServicesNotifier.new,
    );

class AuthServicesNotifier extends AsyncNotifier<AuthModel> {
  @override
  Future<AuthModel> build() {
    return _initialize();
  }

  Future<AuthModel> _initialize() async {
    final [userId, accessToken] = await Future.wait([
      ref.read(flutterSecureStorageProvider).getValue(StorageKeys.userId),
      ref.read(flutterSecureStorageProvider).getValue(StorageKeys.accessToken),
    ]);

    if (userId != null && accessToken != null) {
      return AuthModel(
        authState: AuthState.authenticated,
        accessToken: accessToken,
        userId: userId,
      );
    } else {
      return AuthModel(
        authState: AuthState.unauthenticated,
        accessToken: null,
        userId: null,
      );
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final response = await AsyncValue.guard(
      () => ref
          .read(authRespositoryProvider)
          .signInWithEmailAndPassword(email: email, password: password),
    );

    response.maybeMap(
      data: (data) async {
        state = AsyncData(
          AuthModel(
            authState: AuthState.authenticated,
            userId: data.value.userId,
            accessToken: data.value.token,
          ),
        );
        debugPrint("From AuthServices signInWithEmailAndPassword");
        await Future.wait([
          ref
              .read(flutterSecureStorageProvider)
              .setValue(
                StorageKeys.accessToken,
                state.requireValue.accessToken!,
              ),

          ref
              .read(flutterSecureStorageProvider)
              .setValue(StorageKeys.userId, state.requireValue.userId!),
        ]);
      },
      error: (AsyncError error) => throw error.error,

      // error: (error) {
      //   state = AsyncError(error.error, error.stackT race);
      // },
      loading: (_) {
        state = const AsyncLoading();
      },
      orElse: () {},
    );
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String confirmPassword,
    required String username,
  }) async {
    // Implement sign-up logic here
  }
  Future<void> signOut() async {
    // Implement sign-out logic here
  }
  Future<bool> isSignedIn() async {
    // Implement check for signed-in status here
    return false; // Placeholder return value
  }

  Future<String?> getCurrentUserId() async {
    // Implement logic to get the current user ID here
    return null; // Placeholder return value
  }
}
