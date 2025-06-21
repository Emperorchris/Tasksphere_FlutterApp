import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasksphere_riverpod/common/exceptions/exceptions.dart';
import 'package:tasksphere_riverpod/features/project/domain/project_model.dart';
import 'package:tasksphere_riverpod/features/project/domain/project_repository.dart';

final projectServiceProvider =
    NotifierProvider<ProjectServiceNotifier, ProjectModel>(
      ProjectServiceNotifier.new,
    );

class ProjectServiceNotifier extends Notifier<ProjectModel> {
  @override
  build() {
    return ProjectModel();
  }

  Future<void> createProject({
    required String adminId,
    required String name,
    required File image,
    required String description,
    required String startDate,
    required String endDate,
    required ProjectStatus status,
  }) async {
    final response = await AsyncValue.guard(
      () => ref
          .read(projectRepositoryProvider)
          .createProject(
            adminId: adminId,
            name: name,
            image: image,
            description: description,
            startDate: startDate,
            endDate: endDate,
            status: status,
          ),
    );

    response.maybeMap(
      data: (data) {
        // state = ProjectModel(
        //   status: ProjectStatus.created,
        //   message: 'Project created successfully',
        // );
      },
      error: (AsyncError error) {
        debugPrint(error.error.toString());
        throw error.error;
      },
      orElse: () {},
    );
  }

  Future<List<ProjectModel>> getUserProjects() async {
    final response = await AsyncValue.guard(
      () => ref.read(projectRepositoryProvider).getUserProjects(),
    );

    return response.maybeMap(
      data: (projects) async {
        final List<ProjectModel> projectList =
            projects.value
                .map((project) => ProjectModel.fromJson(project.toJson()))
                .toList();

        return projectList;
      },
      error: (error) {
        debugPrint(error.error.toString());
        throw error.error;
      },
      orElse: () => [],
    );
  }
}
