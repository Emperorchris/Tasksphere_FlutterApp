import 'dart:convert';

class User {
  final String? id;
  final String username;
  final String email;
  final String? phone;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? token;

  User({
    this.id,
    required this.username,
    required this.email,
    this.phone,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return User(
      id: data['id'] as String?,
      username: data['username'] as String,
      email: data['email'] as String,
      phone: data['phone'] as String?,
      image: data['image'] as String?,
      createdAt:
          data['created_at'] != null
              ? DateTime.parse(data['created_at'] as String)
              : null,
      updatedAt:
          data['updated_at'] != null
              ? DateTime.parse(data['updated_at'] as String)
              : null,
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phone': phone,
      'image': image,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'token': token,
    };
  }

  User copyWith({
    String? id,
    String? username,
    String? email,
    String? phone,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      token: token ?? this.token,
    );
  }
}
