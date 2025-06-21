import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasksphere_riverpod/common/exceptions/exceptions.dart';
import 'package:tasksphere_riverpod/features/project/data/dto/create_project_dto.dart';
import 'package:tasksphere_riverpod/features/project/data/dto/get_projects_dto.dart';
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
    required ProjectStatus status,
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
        "status": status.name,
      });

      final response = await _dio.post(
        '/projects',
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      debugPrint('Response: ${response.data}');

      final dto = CreateProjectResponseDto.fromJson(response.data);
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
  Future<List<ProjectModel>> getUserProjects() async {
    try {
      final response = await _dio.get("/projects");

      debugPrint('Response: ${response.data}');

      final dto = GetProjectsResponseDto.fromJson(response.data);
      final projects =
          dto.data.allProjects
              .map(
                (project) => ProjectModel(
                  id: project.id,
                  adminId: project.admin.id,
                  name: project.name,
                  image: project.image,
                  description: project.description,
                  startDate: project.startDate.toString(),
                  endDate: project.endDate.toString(),
                  completionPercentage: project.completionPercentage.toString(),
                  status: ProjectStatus.values.firstWhere(
                    (e) => e.name == project.status,
                    orElse:
                        () => ProjectStatus.upcoming, // Handle unknown status
                  ),
                ),
              )
              .toList();

      return projects;
    } on DioException catch (e) {
      throw ProjectException(
        e.response?.data['message'] ??
            e.response?.data['error'] ??
            "An error occurred while fetching user projects",
      );
    } catch (e) {
      throw ProjectException(
        "An error occurred while fetching user projects: $e",
      );
    }
  }

}
