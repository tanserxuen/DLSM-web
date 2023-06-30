// import 'dart:ffi';

import 'package:dlsm_web/common/index.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/participantRecord.dart';
import '../model/rebate.dart';
import '../services/rebate_service.dart';
import '../widgets/StaItem.dart';

List<ParticipantRecord> participantRecords = [];
// List<Rebate> rebates = [];
List<Rebate> safeDriverRebates = [];
List<Rebate> mileageReductionRebates = [];

class StatisticsPage extends ConsumerStatefulWidget {
  const StatisticsPage({super.key});

  @override
  ConsumerState<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends ConsumerState<StatisticsPage> {
  RebateService get _rebateService => ref.read(rebateServiceProvider);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await getParticipantRecord();
      await getApprovedMileageReduction();
      await getApprovedSafeDriver();
    });
  }

  Future<void> getParticipantRecord() async {
    List<ParticipantRecord> records =
        await _rebateService.fetchParticipantRecord();
    setState(() {
      participantRecords = records;
    });
  }

  Future<void> getApprovedMileageReduction() async {
    List<Rebate> records = await _rebateService.fetchApprovedMileageReduction();
    setState(() {
      mileageReductionRebates = records;
    });
  }

  Future<void> getApprovedSafeDriver() async {
    List<Rebate> records = await _rebateService.fetchApprovedSafeDriver();
    setState(() {
      safeDriverRebates = records;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 15),
          Expanded(
            child: cardList(),
          ),
          const SizedBox(height: 15),
          const Text(
            "Rebate Statistics",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(child: RebateChart()),
          const SizedBox(height: 5),
          const Text(
            "Driving Behavior Statistics",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 3),
          Expanded(
            child: TripCountLineChart(),
          ),
          const SizedBox(height: 3),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ScoreLineChart(),
                ),
                Expanded(
                  child: SpeedingLineChart(),
                )
              ],
            ),
          ),
          SizedBox(height: 3),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: AccelerationLineChart(),
                ),
                Expanded(
                  child: BrakingLineChart(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cardList() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: ((context, index) => StaItem(
              title: getTitle(index),
              value: getValue(index),
            )),
      ),
    );
  }

  String getTitle(int index) {
    switch (index) {
      case 0:
        return "Total Participant";
      case 1:
        return "Total Safe Driver";
      case 2:
        return "Total Mileage Reduction";
      case 3:
        return "Total Rebate";
      default:
        return "Error";
    }
  }

  int getValue(int index) {
    switch (index) {
      case 0:
        return participantRecords.length;
      case 1:
        return safeDriverRebates.length;
      case 2:
        return mileageReductionRebates.length;
      case 3:
        return safeDriverRebates.length + mileageReductionRebates.length;
      default:
        return 0;
    }
  }

  Future<int> getNumOfPreviousApprovedSafeDriver() async {
    return await _rebateService.numOfPreviousApprovedSafeDriver();
  }

  // convert future<int> to int
  int convertFutureInt(Future<int> futureInt) {
    int value = 0;
    futureInt.then((value) => value = value);
    return value;
  }
}

/* Rebate Statistics */
// bar chart with rebate type ammount

class RebateAmount {
  final String rebateType;
  final int amount;

  RebateAmount(this.rebateType, this.amount);
}

SfCartesianChart RebateChart() {
  List<RebateAmount> rebateAmounts = [
    RebateAmount("Safe Driver", safeDriverRebates.length),
    RebateAmount("Mileage Reduction", mileageReductionRebates.length),
  ];

  return SfCartesianChart(
    title: ChartTitle(
        text: 'Approved Rebate', textStyle: const TextStyle(fontSize: 10)),
    legend: Legend(isVisible: true),
    tooltipBehavior: TooltipBehavior(enable: true),
    series: <ChartSeries>[
      ColumnSeries<RebateAmount, dynamic>(
          dataSource: rebateAmounts,
          xValueMapper: (RebateAmount rebateAmount, _) =>
              rebateAmount.rebateType,
          yValueMapper: (RebateAmount rebateAmount, _) => rebateAmount.amount,
          name: 'Rebate Amount',
          dataLabelSettings: DataLabelSettings(isVisible: true)),
    ],
    primaryXAxis: CategoryAxis(
        title:
            AxisTitle(text: 'Type', textStyle: const TextStyle(fontSize: 10))),
    primaryYAxis: NumericAxis(
        title: AxisTitle(
            text: 'Amount', textStyle: const TextStyle(fontSize: 10))),
  );
}

/* Drive Behaviour Chart */

SfCartesianChart TripCountLineChart() {
  return SfCartesianChart(
    title: ChartTitle(
        text: 'Distance vs Overall Score',
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
    legend: Legend(isVisible: true),
    tooltipBehavior: TooltipBehavior(enable: true),
    series: <ChartSeries>[
      LineSeries<ParticipantRecord, dynamic>(
          dataSource: participantRecords,
          xValueMapper: (ParticipantRecord record, _) => record.tripCount,
          yValueMapper: (ParticipantRecord record, _) => record.totalDistance,
          name: 'Distance (km)',
          dataLabelSettings: DataLabelSettings(isVisible: true)),
    ],
    primaryXAxis: NumericAxis(
        title: AxisTitle(
            text: 'Trip Count', textStyle: const TextStyle(fontSize: 10))),
    primaryYAxis: NumericAxis(
        title: AxisTitle(
            text: 'Distance (km)', textStyle: const TextStyle(fontSize: 10))),
  );
}

SfCartesianChart ScoreLineChart() {
  return SfCartesianChart(
    title: ChartTitle(
        text: 'Distance vs Overall Score',
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
    legend: Legend(isVisible: true),
    tooltipBehavior: TooltipBehavior(enable: true),
    series: <ChartSeries>[
      LineSeries<ParticipantRecord, dynamic>(
          dataSource: participantRecords,
          xValueMapper: (ParticipantRecord record, _) => record.totalDistance,
          yValueMapper: (ParticipantRecord record, _) =>
              record.totalOverallScore,
          name: 'Overall Score',
          dataLabelSettings: DataLabelSettings(isVisible: true)),
    ],
    primaryXAxis: NumericAxis(
        title: AxisTitle(
            text: 'Distance (km)', textStyle: const TextStyle(fontSize: 10))),
    primaryYAxis: NumericAxis(
        title: AxisTitle(
            text: 'Overall Score', textStyle: const TextStyle(fontSize: 10))),
  );
}

SfCartesianChart SpeedingLineChart() {
  return SfCartesianChart(
    title: ChartTitle(
        text: 'Distance vs Speeding Score',
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
    legend: Legend(isVisible: true),
    tooltipBehavior: TooltipBehavior(enable: true),
    series: <ChartSeries>[
      LineSeries<ParticipantRecord, dynamic>(
          dataSource: participantRecords,
          xValueMapper: (ParticipantRecord record, _) => record.totalDistance,
          yValueMapper: (ParticipantRecord record, _) =>
              record.totalSpeedingScore,
          name: 'Speeding Score',
          dataLabelSettings: DataLabelSettings(isVisible: true)),
    ],
    primaryXAxis: NumericAxis(
        title: AxisTitle(
            text: 'Distance (km)', textStyle: const TextStyle(fontSize: 10))),
    primaryYAxis: NumericAxis(
        title: AxisTitle(
            text: ' Spending Score', textStyle: const TextStyle(fontSize: 10))),
  );
}

SfCartesianChart AccelerationLineChart() {
  return SfCartesianChart(
    title: ChartTitle(
        text: 'Distance vs Acceleration Score',
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
    legend: Legend(isVisible: true),
    tooltipBehavior: TooltipBehavior(enable: true),
    series: <ChartSeries>[
      LineSeries<ParticipantRecord, dynamic>(
          dataSource: participantRecords,
          xValueMapper: (ParticipantRecord record, _) => record.totalDistance,
          yValueMapper: (ParticipantRecord record, _) =>
              record.totalAccelerationScore,
          name: 'Acceleration Score',
          dataLabelSettings: DataLabelSettings(isVisible: true)),
    ],
    primaryXAxis: NumericAxis(
        title: AxisTitle(
            text: 'Distance (km)', textStyle: const TextStyle(fontSize: 10))),
    primaryYAxis: NumericAxis(
        title: AxisTitle(
            text: 'Acceleration Score',
            textStyle: const TextStyle(fontSize: 10))),
  );
}

SfCartesianChart BrakingLineChart() {
  return SfCartesianChart(
    title: ChartTitle(
        text: 'Distance vs Braking Score',
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
    legend: Legend(isVisible: true),
    tooltipBehavior: TooltipBehavior(enable: true),
    series: <ChartSeries>[
      LineSeries<ParticipantRecord, dynamic>(
          dataSource: participantRecords,
          xValueMapper: (ParticipantRecord record, _) => record.totalDistance,
          yValueMapper: (ParticipantRecord record, _) =>
              record.totalBrakingScore,
          name: 'Braking Score',
          dataLabelSettings: DataLabelSettings(isVisible: true)),
    ],
    primaryXAxis: NumericAxis(
        title: AxisTitle(
            text: 'Distance (km)', textStyle: const TextStyle(fontSize: 10))),
    primaryYAxis: NumericAxis(
        title: AxisTitle(
            text: 'Braking Score', textStyle: const TextStyle(fontSize: 10))),
  );
}
