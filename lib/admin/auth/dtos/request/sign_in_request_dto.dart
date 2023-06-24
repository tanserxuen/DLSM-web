class SignInRequestDTO {
  String phoneNumber;
  String password;

  SignInRequestDTO({required this.phoneNumber, required this.password});

  Map<String, dynamic> toJson() {
    return {
      "phoneNumber": phoneNumber,
      "password": password,
    };
  }
}
