import 'package:tasksphere_riverpod/common/dto/user_dto.dart';
import 'package:tasksphere_riverpod/features/Task/data/dto/task_dto.dart';
import 'package:tasksphere_riverpod/features/project/data/dto/get_projects_dto.dart';
import 'package:tasksphere_riverpod/features/project/data/dto/project_dto.dart';
import 'package:tasksphere_riverpod/features/project/domain/project_details_model.dart';
import 'package:tasksphere_riverpod/features/project/domain/project_model.dart';

class ProjectDetailsResponseDto {
  final Data data;
  final String message;

  ProjectDetailsResponseDto({required this.data, required this.message});

  factory ProjectDetailsResponseDto.fromJson(Map<String, dynamic> json) =>
      ProjectDetailsResponseDto(
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {"data": data.toJson(), "message": message};

  ProjectDetailsModel toProjectDetailsModel() => ProjectDetailsModel(
    // projectModel: data.project.toProjectModel(),
    projectModel: ProjectModel(
      id: data.id,
      adminId: data.admin?.id,
      name: data.name,
      image: data.image,
      description: data.description,
      status: data.status,
      startDate: data.startDate,
      endDate: data.endDate,
      completionPercentage: data.completionPercentage.toString(),
      category: data.category,
    ),
    tasks: (data.tasks ?? []).map((task) => task.data.toTaskModel()).toList(),
    teamMembers:
        (data.users ?? []).map((user) => user.data.toUserModel()).toList(),
  );
}

class Data {
  // final ProjectResponseDto project;
  // final ProjectDto project;
  final String id;
  final AdminDto? admin;
  final String name;
  final String? image;
  final String description;
  final String? status;
  final dynamic startDate;
  final dynamic endDate;
  final int? completionPercentage;
  final String? category;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<UserResponseDto>? users;
  final List<TaskResponseDto>? tasks;

  Data({
    required this.id,
    this.admin,
    required this.name,
    this.image,
    required this.description,
    this.status,
    this.startDate,
    this.endDate,
    required this.completionPercentage,
    this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.users,
    required this.tasks,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    admin: json["admin"] != null ? AdminDto.fromJson(json["admin"]) : null,
    name: json["name"],
    image: json["image"],
    description: json["description"],
    status: json["status"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    completionPercentage: json["completionPercentage"],
    category: json["category"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    users:
        json["users"] != null
            ? List<UserResponseDto>.from(
              json["users"].map((x) => UserResponseDto.fromJson(x)),
            )
            : null,
    tasks:
        json["tasks"] != null
            ? List<TaskResponseDto>.from(
              json["tasks"].map((x) => TaskResponseDto.fromJson(x)),
            )
            : null,
  );

  Map<String, dynamic> toJson() => {
    // "project": project.toJson(),
    "id": id,
    "admin": admin?.toJson(),
    "name": name,
    "image": image,
    "description": description,
    "status": status,
    "startDate": startDate,
    "endDate": endDate,
    "completionPercentage": completionPercentage,
    "category": category,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "users": List<dynamic>.from((users ?? []).map((x) => x.toJson())),
    "tasks": List<dynamic>.from((tasks ?? []).map((x) => x.toJson())),
  };
}
