import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasksphere_riverpod/common/exceptions/exceptions.dart';
import 'package:tasksphere_riverpod/features/project/domain/project_details_model.dart';
import 'package:tasksphere_riverpod/features/project/domain/project_model.dart';
import 'package:tasksphere_riverpod/features/project/services/project_service.dart';

final projectNotifierProvider =
    AsyncNotifierProvider<ProjectNotifier, Map<String, List<ProjectModel>>>(
      ProjectNotifier.new,
    );

class ProjectNotifier extends AsyncNotifier<Map<String, List<ProjectModel>>> {
  @override
  build() async {
    state = const AsyncLoading();
    final projectsMap = await getUserProjects();
    return projectsMap;
  }

  Future<void> createProject({
    required String adminId,
    required String name,
    required File image,
    required String description,
    required String startDate,
    required String endDate,
    required String status,
  }) async {
    try {
      await ref
          .read(projectServiceProvider.notifier)
          .createProject(
            adminId: adminId,
            name: name,
            image: image,
            description: description,
            startDate: startDate,
            endDate: endDate,
            status: status,
          );

      state = await AsyncValue.guard(() async {
        final projectsMap = await getUserProjects();
        return projectsMap;
      });
    } on ProjectException {
      rethrow;
    } catch (e) {
      // Handle exceptions, e.g., show a message to the user
      throw Exception('Project creation failed: ${e.toString()}');
    }
  }

  Future<Map<String, List<ProjectModel>>> getUserProjects() async {
    try {
      final projects =
          await ref.read(projectServiceProvider.notifier).getUserProjects();
      state = AsyncData(projects);
      return projects;
    } on ProjectException {
      rethrow;
    } catch (e) {
      // Handle exceptions, e.g., show a message to the user
      throw Exception('Fetching projects failed: ${e.toString()}');
    }
  }

  Future<void> refreshProjects() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(getUserProjects);
  }



  // Future<void> updateProject({
  //   required String projectId,
  //   required String name,
  //   required File? image,
  //   required String description,
  //   required String startDate,
  //   required String endDate,
  //   required ProjectStatus status,
  // }) async {
  //   try {
  //     await ref.read(projectServiceProvider.notifier).updateProject(
  //           projectId: projectId,
  //           name: name,
  //           image: image,
  //           description: description,
  //           startDate: startDate,
  //           endDate: endDate,
  //           status: status,
  //         );

  //     state = await AsyncValue.guard(() async {
  //       final projectsMap = await getUserProjects();
  //       return projectsMap;
  //     });
  //   } on ProjectException {
  //     rethrow;
  //   } catch (e) {
  //     // Handle exceptions, e.g., show a message to the user
  //     throw Exception('Project update failed: ${e.toString()}');
  //   }
  // }
}
