import 'package:tasksphere_riverpod/common/models/user_model.dart';
import 'package:tasksphere_riverpod/models/user_model.dart';

class UserResponseDto {
  final Data data;
  final String token;
  final String message;

  UserResponseDto({
    required this.data,
    required this.token,
    required this.message,
  });

  factory UserResponseDto.fromJson(Map<String, dynamic> json) =>
      UserResponseDto(
        data: Data.fromJson(json["data"]),
        token: json["token"],
        message: json["message"],
      );

  User toUserModel() => User(
    id: data.id,
    username: data.username,
    email: data.email,
    phone: data.phone,
    image: data.image,
    createdAt: data.createdAt,
    updatedAt: data.updatedAt,
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "token": token,
    "message": message,
  };
}

class Data {
  final String id;
  final String username;
  final String email;
  final dynamic phone;
  final dynamic image;
  final DateTime createdAt;
  final DateTime updatedAt;

  Data({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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

  UserModel toUserModel() => UserModel(
    id: id,
    username: username,
    email: email,
    phone: phone,
    image: image,
    createdAt: createdAt,
    updatedAt: updatedAt,
    token: '', // Token is not part of this DTO, so we set it to an empty string
  );
}
