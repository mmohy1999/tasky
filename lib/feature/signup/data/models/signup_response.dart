class SignupResponse{
  String? id;
  String? accessToken;
  String? refreshToken;

  SignupResponse({this.id, this.accessToken, this.refreshToken});

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      id: json['_id'] as String?,
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
    );
  }
}