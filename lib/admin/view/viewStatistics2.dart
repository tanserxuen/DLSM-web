import 'dart:ffi';

import 'package:dlsm_web/common/index.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/participantRecord.dart';
import '../services/rebate_service.dart';
import '../widgets/StaItem.dart';

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
      await _rebateService.numOfPreviousApprovedSafeDriver();
      await _rebateService.numOfPreviousApprovedMileageReduction();
      await _rebateService.numOfPreviousApprovedRebate();
      await _rebateService.fetchParticipantRecord();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: cardList(),
          ),
          SizedBox(height: 20),
          Text(
            "Driving Behavior Statistcs",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Expanded(
            child: TripCountLineChart(),
          ),
          SizedBox(height: 20),
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
          SizedBox(height: 20),
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
    return Container(
      height: 200,
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
    int value = 0;
    switch (index) {
      case 0:
        return 100;
      case 1:
        value =
            convertFutureInt(_rebateService.numOfPreviousApprovedSafeDriver());
        print("safe driver: " + value.toString());
        return value;
      case 2:
        value = convertFutureInt(getNumOfPreviousApprovedSafeDriver());
        return value;
      case 3:
        value = convertFutureInt(getNumOfPreviousApprovedSafeDriver());
        return value;
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

class TripCountLineChart extends ConsumerStatefulWidget {
  @override
  ConsumerState<TripCountLineChart> createState() => _TripCountLineChartState();
}

class _TripCountLineChartState extends ConsumerState<TripCountLineChart> {
  // get participant record from rebate service
  RebateService get _rebateService => ref.read(rebateServiceProvider);

  List<ParticipantRecord> participantRecords = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await getParticipantRecord();
    });
  }

  Future<void> getParticipantRecord() async {
    List<ParticipantRecord> records =
        await _rebateService.fetchParticipantRecord();
    setState(() {
      participantRecords = records;
    });
    print(participantRecords);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: SfCartesianChart(
            title: ChartTitle(text: 'Distance vs Overall Score'),
            legend: Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries>[
              LineSeries<ParticipantRecord, dynamic>(
                  dataSource: participantRecords,
                  xValueMapper: (ParticipantRecord record, _) =>
                      record.tripCount,
                  yValueMapper: (ParticipantRecord record, _) =>
                      record.totalDistance,
                  name: 'Distance (km)',
                  dataLabelSettings: DataLabelSettings(isVisible: true)),
            ],
            primaryXAxis: NumericAxis(),
            primaryYAxis: NumericAxis(),
          ),
        ),
      ),
    );
  }
}

class ScoreLineChart extends ConsumerStatefulWidget {
  @override
  ConsumerState<ScoreLineChart> createState() => _ScoreLineChartState();
}

class _ScoreLineChartState extends ConsumerState<ScoreLineChart> {
  // get participant record from rebate service
  RebateService get _rebateService => ref.read(rebateServiceProvider);

  List<ParticipantRecord> participantRecords = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await getParticipantRecord();
    });
  }

  Future<void> getParticipantRecord() async {
    List<ParticipantRecord> records =
        await _rebateService.fetchParticipantRecord();
    setState(() {
      participantRecords = records;
    });
    print(participantRecords);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: SfCartesianChart(
            title: ChartTitle(text: 'Distance vs Overall Score'),
            legend: Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries>[
              LineSeries<ParticipantRecord, dynamic>(
                  dataSource: participantRecords,
                  xValueMapper: (ParticipantRecord record, _) =>
                      record.totalDistance,
                  yValueMapper: (ParticipantRecord record, _) =>
                      record.totalOverallScore,
                  name: 'Overall Score',
                  dataLabelSettings: DataLabelSettings(isVisible: true)),
            ],
            primaryXAxis: NumericAxis(),
            primaryYAxis: NumericAxis(),
          ),
        ),
      ),
    );
  }
}

class SpeedingLineChart extends ConsumerStatefulWidget {
  @override
  ConsumerState<SpeedingLineChart> createState() => _SpeedingLineChartState();
}

class _SpeedingLineChartState extends ConsumerState<SpeedingLineChart> {
  // get participant record from rebate service
  RebateService get _rebateService => ref.read(rebateServiceProvider);

  List<ParticipantRecord> participantRecords = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await getParticipantRecord();
    });
  }

  Future<void> getParticipantRecord() async {
    List<ParticipantRecord> records =
        await _rebateService.fetchParticipantRecord();
    setState(() {
      participantRecords = records;
    });
    print(participantRecords);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: SfCartesianChart(
            title: ChartTitle(text: 'Distance vs Speeding Score'),
            legend: Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries>[
              LineSeries<ParticipantRecord, dynamic>(
                  dataSource: participantRecords,
                  xValueMapper: (ParticipantRecord record, _) =>
                      record.totalDistance,
                  yValueMapper: (ParticipantRecord record, _) =>
                      record.totalSpeedingScore,
                  name: 'Speeding Score',
                  dataLabelSettings: DataLabelSettings(isVisible: true)),
            ],
            primaryXAxis: NumericAxis(),
            primaryYAxis: NumericAxis(),
          ),
        ),
      ),
    );
  }
}

class AccelerationLineChart extends ConsumerStatefulWidget {
  @override
  ConsumerState<AccelerationLineChart> createState() =>
      _AccelerationLineChartState();
}

class _AccelerationLineChartState extends ConsumerState<AccelerationLineChart> {
  // get participant record from rebate service
  RebateService get _rebateService => ref.read(rebateServiceProvider);

  List<ParticipantRecord> participantRecords = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await getParticipantRecord();
    });
  }

  Future<void> getParticipantRecord() async {
    List<ParticipantRecord> records =
        await _rebateService.fetchParticipantRecord();
    setState(() {
      participantRecords = records;
    });
    print(participantRecords);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: SfCartesianChart(
            title: ChartTitle(text: 'Distance vs Acceleration Score'),
            legend: Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries>[
              LineSeries<ParticipantRecord, dynamic>(
                  dataSource: participantRecords,
                  xValueMapper: (ParticipantRecord record, _) =>
                      record.totalDistance,
                  yValueMapper: (ParticipantRecord record, _) =>
                      record.totalAccelerationScore,
                  name: 'Acceleration Score',
                  dataLabelSettings: DataLabelSettings(isVisible: true)),
            ],
            primaryXAxis: NumericAxis(),
            primaryYAxis: NumericAxis(),
          ),
        ),
      ),
    );
  }
}

class BrakingLineChart extends ConsumerStatefulWidget {
  @override
  ConsumerState<BrakingLineChart> createState() => _BrakingLineChartState();
}

class _BrakingLineChartState extends ConsumerState<BrakingLineChart> {
  // get participant record from rebate service
  RebateService get _rebateService => ref.read(rebateServiceProvider);

  List<ParticipantRecord> participantRecords = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await getParticipantRecord();
    });
  }

  Future<void> getParticipantRecord() async {
    List<ParticipantRecord> records =
        await _rebateService.fetchParticipantRecord();
    setState(() {
      participantRecords = records;
    });
    print(participantRecords);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: SfCartesianChart(
            title: ChartTitle(text: 'Distance vs Braking Score'),
            legend: Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries>[
              LineSeries<ParticipantRecord, dynamic>(
                  dataSource: participantRecords,
                  xValueMapper: (ParticipantRecord record, _) =>
                      record.totalDistance,
                  yValueMapper: (ParticipantRecord record, _) =>
                      record.totalBrakingScore,
                  name: 'Braking Score',
                  dataLabelSettings: DataLabelSettings(isVisible: true)),
            ],
            primaryXAxis: NumericAxis(),
            primaryYAxis: NumericAxis(),
          ),
        ),
      ),
    );
  }
}
