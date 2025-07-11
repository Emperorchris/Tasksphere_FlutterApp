import 'dart:convert';

class UserModel {
  final String id;
  final String username;
  final String email;
  final String? phone;
  final String? image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String token;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.token,
  });

  UserModel copyWith({
    String? id,
    String? username,
    String? email,
    String? phone,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? token,
  }) {
    return UserModel(
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

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'username': username});
    result.addAll({'email': email});
    if(phone != null){
      result.addAll({'phone': phone});
    }
    if(image != null){
      result.addAll({'image': image});
    }
    result.addAll({'createdAt': createdAt.millisecondsSinceEpoch});
    result.addAll({'updatedAt': updatedAt.millisecondsSinceEpoch});
    result.addAll({'token': token});
  
    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'],
      image: map['image'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, username: $username, email: $email, phone: $phone, image: $image, createdAt: $createdAt, updatedAt: $updatedAt, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.id == id &&
      other.username == username &&
      other.email == email &&
      other.phone == phone &&
      other.image == image &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt &&
      other.token == token;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      username.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      image.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      token.hashCode;
  }
}
