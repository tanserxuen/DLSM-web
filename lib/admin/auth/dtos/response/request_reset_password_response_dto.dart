


class RequestResetPasswordResponseDTO {
  String resetPasswordToken;

  RequestResetPasswordResponseDTO({required this.resetPasswordToken});

  factory RequestResetPasswordResponseDTO.fromJson(Map<String, dynamic> json) {
    return RequestResetPasswordResponseDTO(
      resetPasswordToken: json['reset_password_token'],
    );
  }
}