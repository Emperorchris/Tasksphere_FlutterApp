import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasksphere_riverpod/models/user_model.dart';
import 'package:tasksphere_riverpod/providers/auth_provider.dart';
import 'package:tasksphere_riverpod/providers/dio_provider.dart';

class RootScreen extends ConsumerStatefulWidget {
  const RootScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RootScreenState();
}

class _RootScreenState extends ConsumerState<RootScreen> {
  @override
  Widget build(BuildContext context) {
    final dio = ref.watch(dioProvider);

    // Add interceptor once using a valid ref
    if (dio.interceptors.isEmpty) {
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            final authState = ref.read(authControllerProvider);
            if (authState is AsyncData<User?> && authState.value != null) {
              options.headers['Authorization'] =
                  'Bearer ${authState.value!.token}';
            }
            return handler.next(options);
          },
          onError: (error, handler) async {
            if (error.response?.statusCode == 401) {
              await ref.read(authControllerProvider.notifier).logout();
            }
            return handler.next(error);
          },
        ),
      );
    }

    

    return Scaffold(body: Placeholder());
  }
}
