class UserProfileResponseDTO {
  final String id;
  final String fullname;
  final String nickname;
  final String email;
  final String phoneNumber;
  final String idNo;

  UserProfileResponseDTO({
    required this.id,
    required this.fullname,
    required this.nickname,
    required this.email,
    required this.phoneNumber,
    required this.idNo,
  });

  factory UserProfileResponseDTO.fromJson(Map<String, dynamic> json) {
    return UserProfileResponseDTO(
      id: json['_id'],
      fullname: json['fullname'],
      nickname: json['nickname'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      idNo: json['idNo'],
    );
  }

}
