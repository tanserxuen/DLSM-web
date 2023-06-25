
import '../../model/user.dart';


class UserResponseDTO {
  final String id;
  final String phoneNumber;
  final String email;
  final List<String> roles;
  final String fullName;
  final String nickName;
  final String idType;
  final String idNo;
  final String dob;

  UserResponseDTO({
    required this.id,
    required this.phoneNumber,
    required this.email,
    required this.roles,
    required this.fullName,
    required this.nickName,
    required this.idType,
    required this.idNo,
    required this.dob,
  });

  factory UserResponseDTO.fromJson(Map<String, dynamic> json) {
    return UserResponseDTO(
      id: json['_id'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      roles: json['roles'].cast<String>(),
      fullName: json['fullname'],
      nickName: json['nickname'],
      idType: json['idType'],
      idNo: json['idNo'],
      dob: json['dob'],
    );
  }


  User toUser() {
    return User(
      id: id,
      phoneNumber: phoneNumber,
      email: email,
      roles: roles,
      fullName: fullName,
      nickName: nickName,
      idType: idType,
      idNo: idNo,
      dob: dob,
    );
  }
}