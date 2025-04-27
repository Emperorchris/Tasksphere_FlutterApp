import 'dart:convert';

class User {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? profilePicture;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.profilePicture,
  });



  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    String? profilePicture,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    if(name != null){
      result.addAll({'name': name});
    }
    if(email != null){
      result.addAll({'email': email});
    }
    if(phone != null){
      result.addAll({'phone': phone});
    }
    if(address != null){
      result.addAll({'address': address});
    }
    if(profilePicture != null){
      result.addAll({'profilePicture': profilePicture});
    }
  
    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
      profilePicture: map['profilePicture'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, phone: $phone, address: $address, profilePicture: $profilePicture)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.phone == phone &&
      other.address == address &&
      other.profilePicture == profilePicture;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      address.hashCode ^
      profilePicture.hashCode;
  }
}
