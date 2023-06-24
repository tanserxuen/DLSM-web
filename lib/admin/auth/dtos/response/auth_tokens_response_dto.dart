


class AuthTokensResponseDTO {
  String accessToken;
  String refreshToken;

  AuthTokensResponseDTO({required this.accessToken, required this.refreshToken});

  factory AuthTokensResponseDTO.fromJson(Map<String, dynamic> json) {
    return AuthTokensResponseDTO(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }
}