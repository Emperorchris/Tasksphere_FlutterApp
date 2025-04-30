import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasksphere_riverpod/constants/utils.dart';
import 'package:tasksphere_riverpod/models/user_model.dart';

import 'auth_provider.dart';

final dioProvider = Provider((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {
        // 'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      responseType: ResponseType.json,
    ),
  );

  // dio.interceptors.add(
  //   InterceptorsWrapper(
  //     onRequest: (options, handler) async {
  //       // final authState = ref.read(authControllerProvider);
  //       // if (!authState.hasError &&
  //       //     authState.hasValue &&
  //       //     authState.value != null) {
  //       //   options.headers['Authorization'] = 'Bearer ${authState.value!.token}';
  //       // }

  //       final storage = ref.read(secureStorageProvider);
  //       final raw = await storage.read(key: 'user');
  //       if (raw != null) {
  //         final token = User.fromJson(json.decode(raw)).token;

  //         options.headers['Authorization'] = 'Bearer $token';
  //       }
  //       return handler.next(options);
  //     },
  //     onError: (error, handler) async {
  //       if (error.response?.statusCode == 401) {
  //         final authController = ref.read(authControllerProvider.notifier);
  //         await authController.logout();
  //       }
  //       return handler.next(error);
  //     },
  //   ),
  // );

  // dio.interceptors.add(
  //   InterceptorsWrapper(
  //     onRequest: (options, handler) {
  //       final authState = ref.read(authControllerProvider);
  //       if (authState is AsyncData<User> && !authState.hasError && authState.hasValue) {
  //         options.headers['Authorization'] = 'Bearer ${authState.value.token}';
  //       }
  //       return handler.next(options); // Synchronous return
  //     },
  //     onError: (error, handler) async {
  //       if (error.response?.statusCode == 401) {
  //         final authController = ref.read(authControllerProvider.notifier);
  //         await authController.logout();
  //       }
  //       return handler.next(error);
  //     },
  //   ),
  // );

  return dio;
});
