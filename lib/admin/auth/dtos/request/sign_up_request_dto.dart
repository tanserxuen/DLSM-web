

class SignUpRequestDTO {
  String phoneNumber;
  String password;
  String email;
  String fullname;
  String nickname;
  String idType;
  String idNo;
  String dob;

  SignUpRequestDTO({
    required this.phoneNumber,
    required this.password,
    required this.email,
    required this.fullname,
    required this.nickname,
    required this.idType,
    required this.idNo,
    required this.dob,
  });

  Map<String, dynamic> toJson() {
    return {
      "phoneNumber": phoneNumber,
      "password": password,
      "email": email,
      "fullname": fullname,
      "nickname": nickname,
      "idType": idType,
      "idNo": idNo,
      "dob": dob,
    };
  }
}