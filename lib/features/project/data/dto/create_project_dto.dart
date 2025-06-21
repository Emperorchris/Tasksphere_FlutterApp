class CreateProjectResponseDto {
  final Data data;
  final String message;

  CreateProjectResponseDto({required this.data, required this.message});

  factory CreateProjectResponseDto.fromJson(Map<String, dynamic> json) =>
      CreateProjectResponseDto(
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {"data": data.toJson(), "message": message};
}

class Data {
  final String id;
  final Admin admin;
  final String name;
  final String image;
  final String description;
  final String? status;
  final dynamic startDate;
  final dynamic endDate;
  final int completionPercentage;
  final DateTime createdAt;
  final DateTime updatedAt;

  Data({
    required this.id,
    required this.admin,
    required this.name,
    required this.image,
    required this.description,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.completionPercentage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    admin: Admin.fromJson(json["admin"]),
    name: json["name"],
    image: json["image"],
    description: json["description"],
    status: json["status"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    completionPercentage: json["completion_percentage"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "admin": admin.toJson(),
    "name": name,
    "image": image,
    "description": description,
    "status": status,
    "start_date": startDate,
    "end_date": endDate,
    "completion_percentage": completionPercentage,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Admin {
  final String id;
  final String username;
  final String email;
  final dynamic phone;
  final dynamic image;
  final DateTime createdAt;
  final DateTime updatedAt;

  Admin({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    phone: json["phone"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
