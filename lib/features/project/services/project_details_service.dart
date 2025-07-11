import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasksphere_riverpod/common/exceptions/exceptions.dart';
import 'package:tasksphere_riverpod/features/project/domain/project_details_model.dart';
import 'package:tasksphere_riverpod/features/project/domain/project_model.dart';
import 'package:tasksphere_riverpod/features/project/domain/project_repository.dart';

final projectDetailsServiceProvider =
    NotifierProvider<ProjectDetailsServiceNotifier, ProjectDetailsModel>(
      ProjectDetailsServiceNotifier.new,
    );

class ProjectDetailsServiceNotifier extends Notifier<ProjectDetailsModel> {
  @override
  build() {
    return ProjectDetailsModel(
      projectModel: ProjectModel(),
      tasks: [],
      teamMembers: [],
    );
  }

  Future<ProjectDetailsModel> getProjectDetails(String projectId) async {
    try {
      final response = await ref
          .read(projectRepositoryProvider)
          .getProjectDetails(projectId);

      return response;
    } on ProjectException catch (e) {
      debugPrint("Error fetching project details: ${e.message}");
      rethrow;
    } catch (e, stackTrace) {
      debugPrint("Unexpected error: $e");
      debugPrint(stackTrace.toString());
      throw ProjectException("An unexpected error occurred: $e");
    }
  }
}
