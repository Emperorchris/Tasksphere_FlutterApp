import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasksphere_riverpod/common/exceptions/exceptions.dart';
import 'package:tasksphere_riverpod/features/project/domain/project_details_model.dart';
import 'package:tasksphere_riverpod/features/project/domain/project_model.dart';
import 'package:tasksphere_riverpod/features/project/services/project_details_service.dart';
import 'package:tasksphere_riverpod/features/project/services/project_service.dart';

final projectDetailsNotifierProvider = AsyncNotifierProvider.autoDispose
    .family<ProjectDetailsNotifier, ProjectDetailsModel, String>(
      ProjectDetailsNotifier.new,
    );

class ProjectDetailsNotifier
    extends AutoDisposeFamilyAsyncNotifier<ProjectDetailsModel, String> {
  @override
  Future<ProjectDetailsModel> build(String projectId) async {
    try {
      state = const AsyncValue.loading();
      final res = await ref
          .read(projectDetailsServiceProvider.notifier)
          .getProjectDetails(projectId);
      state = AsyncValue.data(res);
      return res;
    } catch (e, stackTrace) {
      debugPrint('Error in notifier: $e\n$stackTrace');
      rethrow;
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref
          .read(projectDetailsServiceProvider.notifier)
          .getProjectDetails(arg),
    );
  }
}
