

class ResetPasswordRequestDTO {
  String code;
  String newPassword;

  ResetPasswordRequestDTO({required this.code, required this.newPassword});

  Map<String, dynamic> toJson() {
    return {
      "code": code,
      "newPassword": newPassword,
    };
  }
}