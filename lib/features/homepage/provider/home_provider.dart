import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasksphere_riverpod/features/auth/domain/auth_model.dart';
import 'package:tasksphere_riverpod/features/auth/presentation/login_screen.dart';
import 'package:tasksphere_riverpod/features/auth/services/auth_services.dart';
import 'package:tasksphere_riverpod/pages/userDashboard/root_screen.dart';

final homeNotifierProvider =
    NotifierProvider<HomeProviderNotifier, AsyncValue<AuthState>>(
      HomeProviderNotifier.new,
    );

class HomeProviderNotifier extends Notifier<AsyncValue<AuthState>> {
  @override
  build() {
    _initialize();
    return const AsyncValue.loading();
  }

  Future<void> _initialize() async {
    try {
      final response = await ref.read(authServicesProvider.notifier).build();
      state = AsyncValue.data(response.authState);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      debugPrint("Error initializing HomeProvider: $e");
    }
  }

  Future<void> navigateToDashboard(BuildContext context) async {
    // final auth = await ref.read(authServicesProvider.future);
    if (state.isLoading) {
      await _initialize();
    }

    // Handle error state if needed
    if (state.hasError) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
      return;
    }

    switch (state.requireValue) {
      case AuthState.authenticated:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RootScreen()),
        );
        break;
      case AuthState.unauthenticated:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
        break;
      default:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
    }
  }
}
