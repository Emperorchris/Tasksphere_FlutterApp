import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tasksphere_riverpod/common/exceptions/exceptions.dart';
import 'package:tasksphere_riverpod/features/project/data/dto/project_dto.dart';
import 'package:tasksphere_riverpod/features/project/data/dto/get_projects_dto.dart';
import 'package:tasksphere_riverpod/features/project/data/dto/project_details_dto.dart';
import 'package:tasksphere_riverpod/features/project/domain/project_details_model.dart';
import 'package:tasksphere_riverpod/features/project/domain/project_model.dart';
import 'package:tasksphere_riverpod/features/project/domain/project_repository.dart';

class RemoteProjectRepository implements ProjectRepository {
  final Dio _dio;

  RemoteProjectRepository(this._dio);
  @override
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
      final multipartImage = await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      );

      final formData = FormData.fromMap({
        "admin_id": adminId,
        "name": name,
        "image": multipartImage,
        "description": description,
        "start_date": startDate,
        "end_date": endDate,
        "status": status,
      });

      final response = await _dio.post(
        '/projects',
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      // final dto = ProjectResponseDto.fromJson(response.data);
      final dto = ProjectDto.fromJson(response.data);
    } on DioException catch (e) {
      throw ProjectException(
        e.response?.data['message'] ??
            e.response?.data['error'] ??
            "An error occurred while creating the project",
      );
    } catch (e) {
      throw ProjectException(
        "An error occurred while creating the project: $e",
      );
    }
  }

  @override
  Future<Map<String, List<ProjectModel>>> getUserProjects() async {
    try {
      final response = await _dio.get("/projects");
      debugPrint('Response: ${response.data}');

      final dto = GetProjectsResponseDto.fromJson(response.data);
      debugPrint('ProjectsLength: ${dto.data.allProjects.length}');
      debugPrint('Admin projectsLength: ${dto.data.adminProjects.length}');
      return dto.toProjectModelsMap();
    } on DioException catch (e) {
      final errorData = e.response?.data;
      final errorMessage =
          errorData is Map
              ? errorData['message'] ?? errorData['error'] ?? e.message
              : e.message;

      throw ProjectException(
        errorMessage ?? "An error occurred while fetching user projects",
      );
    } catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      throw ProjectException("An unexpected error occurred: $e");
    }
  }

  // @override
  // Future<Map<String, List<ProjectModel>>> getUserProjects() async {
  //   try {
  //     final response = await _dio.get("/projects");

  //     debugPrint('Response: ${response.data}');

  //     final dto = GetProjectsResponseDto.fromJson(response.data);
  //     final projects = dto.toProjectModelsMap();
  //     // final projects =
  //     //     dto.data.allProjects
  //     //         .map((project) => project.data.toProjectModel())
  //     //         .toList();

  //     // debugPrint('Projects: $projects');

  //     // final projects =
  //     //     dto.data.allProjects
  //     //         .map(
  //     //           (project) => ProjectModel(
  //     //             id: project.id,
  //     //             adminId: project.admin.id,
  //     //             name: project.name,
  //     //             image: project.image,
  //     //             description: project.description,
  //     //             startDate: project.startDate.toString(),
  //     //             endDate: project.endDate.toString(),
  //     //             completionPercentage: project.completionPercentage.toString(),
  //     //             status: ProjectStatus.values.firstWhere(
  //     //               (e) => e.name == project.status,
  //     //               orElse:
  //     //                   () => ProjectStatus.upcoming, // Handle unknown status
  //     //             ),
  //     //           ),
  //     //         )
  //     //         .toList();

  //     return projects;
  //   } on DioException catch (e) {
  //     throw ProjectException(
  //       e.response?.data['message'] ??
  //           e.response?.data['error'] ??
  //           "An error occurred while fetching user projects",
  //     );
  //   } catch (e, stackTrace) {
  //     debugPrint(stackTrace.toString());
  //     throw ProjectException(
  //       "An error occurred while fetching user projects: $e",
  //     );
  //   }
  // }

  @override
  Future<ProjectDetailsModel> getProjectDetails(String projectId) async {
    try {
      final response = await _dio.get("/projects/$projectId");
      debugPrint('Raw API Response: ${response.data}');
      // if (response.data == null || response.data['data'] == null) {
      //   throw ProjectException("No project data received");
      // }
      final dto = ProjectDetailsResponseDto.fromJson(response.data);
      debugPrint('DTO Response: ${dto.toString()}');
      return dto.toProjectDetailsModel();
    } on DioException catch (e) {
      throw ProjectException(
        e.response?.data['message'] ??
            e.response?.data['error'] ??
            "An error occurred while fetching project details",
      );
    } catch (e) {
      throw ProjectException(
        "An error occurred while fetching project details: $e",
      );
    }
  }
}
