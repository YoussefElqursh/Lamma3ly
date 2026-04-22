/// Response model for authentication API calls.
///
/// Contains both the user data and authentication tokens.
class AuthResponseModel {
  final String accessToken;
  final String refreshToken;
  final Map<String, dynamic> user;

  const AuthResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      user: json['user'] as Map<String, dynamic>,
    );
  }
}
