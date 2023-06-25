import 'package:dlsm_web/admin/model/rebate.dart';

class ParticipantRecord {
  final String user;
  final String campaign;
  final int tripCount;
  final double totalDistance;
  final double totalOverallScore;
  final double totalSpeedingScore;
  final double totalAccelerationScore;
  final double totalBrakingScore;
  // final List<Rebate> rebateRecord;

  ParticipantRecord({
    required this.user,
    required this.campaign,
    required this.tripCount,
    required this.totalDistance,
    required this.totalOverallScore,
    required this.totalSpeedingScore,
    required this.totalAccelerationScore,
    required this.totalBrakingScore,
    // required this.rebateRecord,
  });

  factory ParticipantRecord.fromJson(Map<String, dynamic> json) {
    return ParticipantRecord(
      user: json['user'],
      campaign: json['campaign'],
      tripCount: json['tripCount'],
      totalDistance: json['totalDistance'],
      totalOverallScore: json['totalOverallScore'],
      totalSpeedingScore: json['totalSpeedingScore'],
      totalAccelerationScore: json['totalAccelerationScore'],
      totalBrakingScore: json['totalBrakingScore'],
      // rebateRecord: json['rebateRecord'],
    );
  }
}
