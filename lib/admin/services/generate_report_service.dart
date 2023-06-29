// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:dlsm_web/admin/model/report.dart';
import 'package:dlsm_web/admin/states/report_list_state.dart';
import 'package:dlsm_web/app/index.dart';
import 'package:dlsm_web/common/index.dart';

final generateReportServiceProvider = Provider<GenerateReportService>(
  (ref) => GenerateReportService(ref),
);

class GenerateReportService extends RiverpodService {
  //Constructor
  GenerateReportService(ProviderRef ref) : super(ref);
  Logger get _logger => ref.read(loggerServiceProvider);
  List rebateList = [];
  Dio get _dio => ref.read(dioServiceProvider).backendDio;
  ReportListStateNotifier get _reportStateNotifier =>
      ref.read(reportListStateProvider.notifier);

  Future<List> fetchRebate(uId) async {
    try {
      Response response = await _dio.get(
        'admin/records/$uId',
      );
      _logger.i(response.data);

      List<Report> rebates = [];
      for (var i = 0; i < response.data.length; i++) {
        rebates.add(Report.fromJson(response.data[i]));
      }
      _reportStateNotifier.setReportList(rebates);
      _logger.i("doneeeeeeeeeeeeeeeeeeeeeeeeee");
    } catch (e) {
      _logger.e('fetch rebate $e');
    }
    throw Exception('Failed to load data');
  }
}
