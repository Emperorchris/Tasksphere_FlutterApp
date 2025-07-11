import 'package:tasksphere_riverpod/features/project/data/dto/project_dto.dart';
import 'package:tasksphere_riverpod/features/project/domain/project_model.dart';

class GetProjectsResponseDto {
  final ProjectsData data;
  final String message;

  GetProjectsResponseDto({required this.data, required this.message});

  factory GetProjectsResponseDto.fromJson(Map<String, dynamic> json) =>
      GetProjectsResponseDto(
        data: ProjectsData.fromJson(json["data"]),
        message: json["message"] as String? ?? '',
      );

  Map<String, List<ProjectModel>> toProjectModelsMap() {
    return {
      'allProjects': data.allProjects.map((e) => e.toProjectModel()).toList(),
      'adminProjects':
          data.adminProjects.map((e) => e.toProjectModel()).toList(),
    };
  }
}

class ProjectsData {
  final List<ProjectDto> allProjects;
  final List<ProjectDto> adminProjects;

  ProjectsData({required this.allProjects, required this.adminProjects});

  factory ProjectsData.fromJson(Map<String, dynamic> json) {
    return ProjectsData(
      allProjects:
          (json["all_projects"] as List? ?? [])
              .map((projectJson) => ProjectDto.fromJson(projectJson))
              .toList(),
      adminProjects:
          (json["admin_projects"] as List? ?? [])
              .map((projectJson) => ProjectDto.fromJson(projectJson))
              .toList(),
    );
  }
}










// import 'package:tasksphere_riverpod/features/project/data/dto/project_dto.dart';
// import 'package:tasksphere_riverpod/features/project/domain/project_model.dart';

// class GetProjectsResponseDto {
//   final Data data;
//   final String message;

//   GetProjectsResponseDto({required this.data, required this.message});

//   factory GetProjectsResponseDto.fromJson(Map<String, dynamic> json) =>
//       GetProjectsResponseDto(
//         data: Data.fromJson(json["data"]),
//         message: json["message"],
//       );

//   /// Converts the first project in allProjects to a ProjectModel, if available.
//   // List<ProjectModel> toProjectModel() {
//   //   return data.allProjects
//   //       .map((project) => project.data.toProjectModel())
//   //       .toList();
//   // }

//   Map<String, List<ProjectModel>> toProjectModelsMap() {
//     return {
//       'allProjects':
//           data.allProjects.map((e) => e.data.toProjectModel()).toList(),
//       'adminProjects':
//           data.adminProjects.map((e) => e.data.toProjectModel()).toList(),
//     };
//   }

//   Map<String, dynamic> toJson() => {"data": data.toJson(), "message": message};
// }

// class Data {
//   final List<ProjectResponseDto> allProjects;
//   final List<ProjectResponseDto> adminProjects;

//   Data({required this.allProjects, required this.adminProjects});

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     allProjects: List<ProjectResponseDto>.from(
//       json["all_projects"].map((x) => ProjectResponseDto.fromJson(x)),
//     ),
//     adminProjects: List<ProjectResponseDto>.from(
//       json["admin_projects"].map((x) => ProjectResponseDto.fromJson(x)),
//     ),
//   );


//   Map<String, dynamic> toJson() => {
//     "all_projects": List<ProjectModel>.from(allProjects.map((x) => x.toJson())),
//     "admin_projects": List<ProjectModel>.from(adminProjects.map((x) => x.toJson())),
//   };
// }

// class Project {
//   final String id;
//   final Admin admin;
//   final String name;
//   final String? image;
//   final String description;
//   final String status;
//   final DateTime? startDate;
//   final DateTime? endDate;
//   final int completionPercentage;
//   final String category;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   Project({
//     required this.id,
//     required this.admin,
//     required this.name,
//     required this.image,
//     required this.description,
//     required this.status,
//     required this.startDate,
//     required this.endDate,
//     required this.completionPercentage,
//     required this.category,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Project.fromJson(Map<String, dynamic> json) => Project(
//     id: json["id"],
//     admin: Admin.fromJson(json["admin"]),
//     name: json["name"],
//     image: json["image"],
//     description: json["description"],
//     status: json["status"],
//     startDate:
//         json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
//     endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
//     completionPercentage: json["completion_percentage"],
//     category: json["category"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "admin": admin.toJson(),
//     "name": name,
//     "image": image,
//     "description": description,
//     "status": status,
//     "start_date": startDate?.toIso8601String(),
//     "end_date": endDate?.toIso8601String(),
//     "completion_percentage": completionPercentage,
//     "category": category,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//   };

//   ProjectModel toProjectModel() => ProjectModel(
//     id: id,
//     adminId: admin.id,
//     name: name,
//     image: image,
//     description: description,
//     status: ProjectStatus.values.firstWhere(
//       (e) => e.name == status,
//       orElse: () => ProjectStatus.upcoming,
//     ),
//     startDate: startDate?.toIso8601String(),
//     endDate: endDate?.toIso8601String(),
//     completionPercentage: completionPercentage.toString(),
//   );
// }

// class Admin {
//   final String id;
//   final String username;
//   final String email;
//   final dynamic phone;
//   final dynamic image;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   Admin({
//     required this.id,
//     required this.username,
//     required this.email,
//     required this.phone,
//     required this.image,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Admin.fromJson(Map<String, dynamic> json) => Admin(
//     id: json["id"],
//     username: json["username"],
//     email: json["email"],
//     phone: json["phone"],
//     image: json["image"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "username": username,
//     "email": email,
//     "phone": phone,
//     "image": image,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//   };
// }
