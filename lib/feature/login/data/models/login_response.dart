class LoginResponse{
  String? id;
  String? accessToken;
  String? refreshToken;

  LoginResponse({this.id, this.accessToken, this.refreshToken});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      id: json['_id'] as String?,
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
    );
  }
}