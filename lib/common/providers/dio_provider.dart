import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasksphere_riverpod/common/repositories/storage_repository_provider.dart';
import 'package:flutter/foundation.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(
      BaseOptions(
        baseUrl: "https://developers.sonichoiceservices.com/api/v1",
        headers: {
          // "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    )
    ..interceptors.add(LogInterceptor())
    ..interceptors.add(
      AuthInterceptor(storage: ref.watch(flutterSecureStorageProvider)),
    );
});

// final dioProvider = FutureProvider<Dio>((ref) async {
//   final storage = ref.watch(flutterSecureStorageProvider);
//   final token = await storage.getValue(StorageKeys.accessToken);

//   final dio = Dio(
//     BaseOptions(
//       baseUrl: "https://developers.sonichoiceservices.com/api/v1",
//       headers: {"Accept": "application/json"},
//     ),
//   );

//   dio.interceptors.add(LogInterceptor());
//   dio.interceptors.add(AuthInterceptor(token: token));

//   return dio;
// });

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorageRepository storage;

  AuthInterceptor({required this.storage});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // super.onRequest(options, handler);
    final token = await storage.getValue(StorageKeys.accessToken);
    debugPrint('Token: $token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    // super.onError(err, handler);
    handler.next(err);
  }
}
