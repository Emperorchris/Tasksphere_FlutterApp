import 'dart:convert';

class AuthModel {
  final String? accessToken;
  final String? refreshToken;
  final String? userId;
  final AuthState authState;
  AuthModel({this.authState = AuthState.unauthenticated, this.accessToken, this.refreshToken, this.userId});

  AuthModel copyWith({
    String? accessToken,
    String? refreshToken,
    String? userId,
    AuthState? authState,
  }) {
    return AuthModel(
      authState: authState ?? this.authState,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (accessToken != null) {
      result.addAll({'accessToken': accessToken});
    }
    if (refreshToken != null) {
      result.addAll({'refreshToken': refreshToken});
    }
    if (userId != null) {
      result.addAll({'userId': userId});
    }

    return result;
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      accessToken: map['accessToken'],
      refreshToken: map['refreshToken'],
      userId: map['userId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'AuthModel(accessToken: $accessToken, refreshToken: $refreshToken, userId: $userId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthModel &&
        other.accessToken == accessToken &&
        other.refreshToken == refreshToken &&
        other.userId == userId;
  }

  @override
  int get hashCode =>
      accessToken.hashCode ^ refreshToken.hashCode ^ userId.hashCode;
}

enum AuthState { initial, authenticated, unauthenticated, loading, error }
