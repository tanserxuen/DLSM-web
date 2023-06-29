import 'package:dlsm_web/admin/model/participantRecord.dart';
import 'package:dlsm_web/admin/model/rebate.dart';
import 'package:dlsm_web/admin/model/report.dart';
import 'package:dlsm_web/admin/services/generate_report_service.dart';
import 'package:dlsm_web/app/index.dart';
import 'package:dlsm_web/common/index.dart';
import 'package:dlsm_web/user/dto/index.dart';

final reportListStateProvider =
    StateNotifierProvider<ReportListStateNotifier, ReportListState>(
        (ref) => ReportListStateNotifier(ref));

class ReportListState {
  final List<Report>? reportList;

  bool isLoading;
  ReportListState({this.reportList, this.isLoading = true});
}

class ReportListStateNotifier extends RiverpodStateNotifier<ReportListState> {
  ReportListStateNotifier(StateNotifierProviderRef ref)
      : super(ReportListState(reportList: []), ref);

  void setReportList(List<Report> reportList) {
    state = ReportListState(reportList: reportList, isLoading: false);
  }
}
