import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasksphere_riverpod/common/exceptions/exceptions.dart';
import 'package:tasksphere_riverpod/features/project/domain/project_details_model.dart';
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
    required String status,
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

  Future<Map<String, List<ProjectModel>>> getUserProjects() async {
    final response = await AsyncValue.guard(
      () => ref.read(projectRepositoryProvider).getUserProjects(),
    );

    return response.when(
      data: (projectsMap) => projectsMap,
      error: (error, _) {
        debugPrint("Project fetch error: ${error.toString()}");
        if (error is ProjectException) {
          throw error;
        } else {
          throw ProjectException(
            "Failed to load projects: ${error.toString()}",
          );
        }
      },
      loading: () => {'allProjects': [], 'adminProjects': []},
    );
  }

  
}
