import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasksphere_riverpod/constants/utils.dart';

final dioProvider = Provider((ref) {
  return Dio(
    BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: Duration(minutes: 5),
      receiveTimeout: Duration(minutes: 5),
      headers: {
        // 'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      responseType: ResponseType.json,
    ),
  );
});
