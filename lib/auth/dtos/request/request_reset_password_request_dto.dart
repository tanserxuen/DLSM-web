


class RequestResetPasswordRequestDTO {
  String email;

  RequestResetPasswordRequestDTO({ required this.email });

  Map<String, dynamic> toJson() => {
    "email": email,
  };
}