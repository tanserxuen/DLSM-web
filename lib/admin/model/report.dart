import 'package:dlsm_web/admin/model/rebate.dart';

class Report {
  final String user;
  final String campaign;
  final int tripCount;
  final double totalDistance;
  final double totalOverallScore;
  final double totalSpeedingScore;
  final double totalAccelerationScore;
  final double totalBrakingScore;
  final List<Rebate>? rebateRecord;

  Report({
    required this.user,
    required this.campaign,
    required this.tripCount,
    required this.totalDistance,
    required this.totalOverallScore,
    required this.totalSpeedingScore,
    required this.totalAccelerationScore,
    required this.totalBrakingScore,
    this.rebateRecord,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      user: json['user'],
      campaign: json['campaign'],
      tripCount: json['tripCount'],
      totalDistance: json['totalDistance'],
      totalOverallScore: json['totalOverallScore'],
      totalSpeedingScore: json['totalSpeedingScore'],
      totalAccelerationScore: json['totalAccelerationScore'],
      totalBrakingScore: json['totalBrakingScore'],
      rebateRecord: json['rebateRecords'] != null
          ? (json['rebateRecords'] as List)
              .map((i) => Rebate.fromJson(i))
              .toList()
          : [],
    );
  }
}
