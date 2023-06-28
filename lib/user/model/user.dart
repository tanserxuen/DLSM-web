

class User {
  final String id;
  final String phoneNumber;
  final String email;
  final List<String> roles;
  final String fullName;
  final String nickName;
  final String idType;
  final String idNo;
  final String dob;

  User({
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
}
