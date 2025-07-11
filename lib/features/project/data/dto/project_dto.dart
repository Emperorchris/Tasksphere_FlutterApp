// import 'package:tasksphere_riverpod/features/project/domain/project_model.dart';

// class ProjectResponseDto {
//   final Data data;
//   final String message;

//   ProjectResponseDto({required this.data, required this.message});

//   factory ProjectResponseDto.fromJson(Map<String, dynamic> json) =>
//       ProjectResponseDto(
//         data: Data.fromJson(json["data"]),
//         message: json["message"],
//       );

//   Map<String, dynamic> toJson() => {"data": data.toJson(), "message": message};
// }

// class Data {
//   final String id;
//   final Admin? admin;
//   final String name;
//   final String? image;
//   final String description;
//   final String? status;
//   final dynamic startDate;
//   final dynamic endDate;
//   final int completionPercentage;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   Data({
//     required this.id,
//     this.admin,
//     required this.name,
//     required this.image,
//     required this.description,
//     required this.status,
//     required this.startDate,
//     required this.endDate,
//     required this.completionPercentage,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   ProjectModel toProjectModel() {
//     return ProjectModel(
//       id: id,
//       adminId: admin?.id,
//       name: name,
//       image: image,
//       description: description,
//       status: status != null ? ProjectStatus.values.byName(status!) : null,
//       startDate: startDate,
//       endDate: endDate,
//       completionPercentage: completionPercentage.toString(),
//     );
//   }

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     id: json["id"],
//     admin: json["admin"] == null ? null : Admin.fromJson(json["admin"]),
//     name: json["name"],
//     image: json["image"],
//     description: json["description"],
//     status: json["status"],
//     startDate: json["start_date"],
//     endDate: json["end_date"],
//     completionPercentage: json["completion_percentage"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "admin": admin?.toJson(),
//     "name": name,
//     "image": image,
//     "description": description,
//     "status": status,
//     "start_date": startDate,
//     "end_date": endDate,
//     "completion_percentage": completionPercentage,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//   };
// }

// class Admin {
//   final String id;
//   final String username;
//   final String email;
//   final String? phone;
//   final String? image;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   Admin({
//     required this.id,
//     required this.username,
//     required this.email,
//     this.phone,
//     this.image,
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

import 'package:tasksphere_riverpod/features/project/domain/project_model.dart';

class ProjectDto {
  final String id;
  final AdminDto? admin;
  final String name;
  final String? image;
  final String description;
  final String? status;
  final dynamic startDate;
  final dynamic endDate;
  final int completionPercentage;
  final String? category; // Added based on your response
  final DateTime createdAt;
  final DateTime updatedAt;

  ProjectDto({
    required this.id,
    this.admin,
    required this.name,
    required this.image,
    required this.description,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.completionPercentage,
    this.category,
    required this.createdAt,
    required this.updatedAt,
  });

  ProjectModel toProjectModel() {
    return ProjectModel(
      id: id,
      adminId: admin?.id,
      name: name,
      image: image,
      description: description,
      // status:
      //     status != null && ProjectStatus.values.any((e) => e.name == status)
      //         ? ProjectStatus.values.byName(status!)
      //         : ProjectStatus.upcoming,
      status: status,
      startDate: startDate,
      endDate: endDate,
      completionPercentage: completionPercentage.toString(),
      category: category, // Added
    );
  }

  factory ProjectDto.fromJson(Map<String, dynamic> json) => ProjectDto(
    id: json["id"] as String? ?? '',
    admin: json["admin"] == null ? null : AdminDto.fromJson(json["admin"]),
    name: json["name"] as String? ?? 'Unnamed Project',
    image: json["image"] as String?,
    description: json["description"] as String? ?? '',
    status: json["status"] as String?,
    startDate: json["start_date"],
    endDate: json["end_date"],
    completionPercentage: json["completion_percentage"] as int? ?? 0,
    category: json["category"] as String?,
    createdAt: DateTime.parse(
      json["created_at"] as String? ?? DateTime.now().toIso8601String(),
    ),
    updatedAt: DateTime.parse(
      json["updated_at"] as String? ?? DateTime.now().toIso8601String(),
    ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "admin": admin?.toJson(),
    "name": name,
    "image": image,
    "description": description,
    "status": status,
    "start_date": startDate,
    "end_date": endDate,
    "completion_percentage": completionPercentage,
    "category": category,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class AdminDto {
  final String id;
  final String username;
  final String email;
  final String? phone;
  final String? image;
  final DateTime createdAt;
  final DateTime updatedAt;

  AdminDto({
    required this.id,
    required this.username,
    required this.email,
    this.phone,
    this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AdminDto.fromJson(Map<String, dynamic> json) => AdminDto(
    id: json["id"] as String? ?? '',
    username: json["username"] as String? ?? '',
    email: json["email"] as String? ?? '',
    phone: json["phone"] as String?,
    image: json["image"] as String?,
    createdAt: DateTime.parse(
      json["created_at"] as String? ?? DateTime.now().toIso8601String(),
    ),
    updatedAt: DateTime.parse(
      json["updated_at"] as String? ?? DateTime.now().toIso8601String(),
    ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "phone": phone,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
