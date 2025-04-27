import 'dart:convert';

class Login {
  String? username;
  String? password;

  Login({
    this.username,
    this.password,
  });


 

  Login copyWith({
    String? username,
    String? password,
  }) {
    return Login(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(username != null){
      result.addAll({'username': username});
    }
    if(password != null){
      result.addAll({'password': password});
    }
  
    return result;
  }

  factory Login.fromMap(Map<String, dynamic> map) {
    return Login(
      username: map['username'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Login.fromJson(String source) => Login.fromMap(json.decode(source));

  @override
  String toString() => 'Login(username: $username, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Login &&
      other.username == username &&
      other.password == password;
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}
