

class UpdateUserRequestDto {

  String? phoneNumber;
  String? email;
  String? fullname;
  String? nickname;
  String? idType;
  String? idNo;
  String? dob;

  UpdateUserRequestDto({
    this.phoneNumber,
    this.email,
    this.fullname,
    this.nickname,
    this.idType,
    this.idNo,
    this.dob,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    if (phoneNumber != null) map['phoneNumber'] = phoneNumber;
    if (email != null) map['email'] = email;
    if (fullname != null) map['fullname'] = fullname;
    if (nickname != null) map['nickname'] = nickname;
    if (idType != null) map['idType'] = idType;
    if (idNo != null) map['idNo'] = idNo;
    if (dob != null) map['dob'] = dob;

    return map;
  }
}