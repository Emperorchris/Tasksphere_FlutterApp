import 'dart:convert';

class Register {
  String email;
  String username;
  String password;
  String? confirmPassword;

  Register({
    required this.email,
    required this.username,
    required this.password,
    this.confirmPassword,
  });

 

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'email': email});
    result.addAll({'username': username});
    result.addAll({'password': password});
    if(confirmPassword != null){
      result.addAll({'confirmPassword': confirmPassword});
    }
  
    return result;
  }

  factory Register.fromMap(Map<String, dynamic> map) {
    return Register(
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      confirmPassword: map['confirmPassword'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Register.fromJson(String source) => Register.fromMap(json.decode(source));

  Register copyWith({
    String? email,
    String? username,
    String? password,
    String? confirmPassword,
  }) {
    return Register(
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }
}
