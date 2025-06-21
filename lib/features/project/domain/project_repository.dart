import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasksphere_riverpod/common/providers/dio_provider.dart';
import 'package:tasksphere_riverpod/features/project/data/remote/remote_project_repository.dart';
import 'package:tasksphere_riverpod/features/project/domain/project_model.dart';

final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  return RemoteProjectRepository(ref.read(dioProvider));
});

abstract class ProjectRepository {
  Future<void> createProject({
    required String adminId,
    required String name,
    required File image,
    required String description,
    required String startDate,
    required String endDate,
    required ProjectStatus status,
  });


  Future<List<ProjectModel>> getUserProjects();
}
