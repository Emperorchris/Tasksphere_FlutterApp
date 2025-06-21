import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasksphere_riverpod/common/exceptions/exceptions.dart';
import 'package:tasksphere_riverpod/features/auth/services/auth_services.dart';


final loginNotifierProvider = NotifierProvider<LoginProvider, void>(LoginProvider.new);

class LoginProvider extends Notifier<void> {
  @override
  build() {
    return;
  }

  Future<void> login({required String email, required String password}) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password cannot be empty');
    }
    try {
        debugPrint("From login provider function");
      // Call the sign-in method from AuthServices
      await ref.read(authServicesProvider.notifier).signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on AuthException {
      rethrow;
    } catch (e) {
      // Handle exceptions, e.g., show a message to the user
      throw Exception('Login failed: ${e.toString()}');
    }
  }
}
