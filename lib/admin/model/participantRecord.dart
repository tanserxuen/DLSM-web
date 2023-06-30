import 'package:dlsm_web/admin/model/rebate.dart';

class ParticipantRecord {
  final String id;
  final String user;
  final String campaign;
  final int tripCount;
  final int totalDistance;
  final int totalOverallScore;
  final int totalSpeedingScore;
  final int totalAccelerationScore;
  final int totalBrakingScore;
  final int v;

  ParticipantRecord({
    required this.id,
    required this.user,
    required this.campaign,
    required this.tripCount,
    required this.totalDistance,
    required this.totalOverallScore,
    required this.totalSpeedingScore,
    required this.totalAccelerationScore,
    required this.totalBrakingScore,
    required this.v,
  });

  factory ParticipantRecord.fromJson(Map<String, dynamic> json) {
    return ParticipantRecord(
      id: json['_id'],
      user: json['user'],
      campaign: json['campaign'],
      tripCount: json['tripCount'],
      totalDistance: json['totalDistance'].runtimeType == double
          ? json['totalDistance'].toInt()
          : json['totalDistance'],
      totalOverallScore: json['totalOverallScore'].runtimeType == double
          ? json['totalOverallScore'].toInt()
          : json['totalOverallScore'],
      totalSpeedingScore: json['totalSpeedingScore'].runtimeType == double
          ? json['totalSpeedingScore'].toInt()
          : json['totalSpeedingScore'],
      totalAccelerationScore:
          json['totalAccelerationScore'].runtimeType == double
              ? json['totalAccelerationScore'].toInt()
              : json['totalAccelerationScore'],
      totalBrakingScore: json['totalBrakingScore'].runtimeType == double
          ? json['totalBrakingScore'].toInt()
          : json['totalBrakingScore'],
      v: json['__v'],
    );
  }
}
