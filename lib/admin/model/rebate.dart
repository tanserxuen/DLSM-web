class Rebate {
  final String id;
  final String user;
  final String participantRecord;
  final String campaign;
  final DateTime requestedDate;
  final String rebateType;
  final String status;
  final int v;

  Rebate({
    required this.id,
    required this.user,
    required this.participantRecord,
    required this.campaign,
    required this.requestedDate,
    required this.rebateType,
    required this.status,
    required this.v,
  });

  factory Rebate.fromJson(Map<String, dynamic> json) {
    return Rebate(
      id: json['_id'],
      user: json['user'],
      participantRecord: json['participantRecord'],
      campaign: json['campaign'],
      requestedDate: DateTime.parse(json['requestedDate']),
      rebateType: json['rebateType'],
      status: json['status'],
      v: json['__v'],
    );
  }
}
