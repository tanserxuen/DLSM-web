// import 'package:dio/dio.dart';
import 'package:dlsm_web/admin/model/participantRecord.dart';
import 'package:dlsm_web/admin/model/rebateStatus.dart';
import 'package:dlsm_web/admin/states/rebate_list_state.dart';

import '../../app/index.dart';
import '../../common/index.dart';
import '../../common/services/dio_service.dart';
import 'package:flutter/material.dart';

import '../model/rebate.dart';

final rebateServiceProvider =
    Provider<RebateService>((ref) => RebateService(ref));

class RebateService extends RiverpodService {
  Dio get _dio => ref.read(dioServiceProvider).backendDio;
  Logger get _logger => ref.read(loggerServiceProvider);
  RebateListStateNotifier get _rebateListStateNotifier =>
      ref.read(rebateListStateProvider.notifier);

  RebateService(ProviderRef ref) : super(ref);

  Future<void> fetchData(status) async {
    _rebateListStateNotifier.setIsLoading(true);
    final response = await _dio.get('/rebate/rebate-list');
    // print(response.data);
    final data = response.data as List<dynamic>;
    final List<Rebate> dataList = data
        .map((e) => Rebate.fromJson(e))
        .where((rebate) => rebate.status == status)
        .toList();
    _logger.i(dataList);
    _rebateListStateNotifier.setRebateList(dataList);
  }

  Future<ParticipantRecord> fetchParticipantRecord(
      String user, String campaign) async {
    final response = await _dio.get('/admin/records/$user');
    // print(response.data);
    // filter by campaign
    // print(response);
    final data = response.data as List<dynamic>;
    // print(data);
    final dataList = data
        .map((e) => ParticipantRecord.fromJson(e))
        .where((record) => record.campaign == campaign)
        .toList();
    // print(dataList);
    // print(dataList[0].totalOverallScore);
    // print(dataList[0].totalSpeedingScore);
    // print(dataList[0].totalDistanceScore);
    return dataList[0];
  }

  // update status of rebate
  Future<void> updateRebateStatus(String id, String status) async {
    final response =
        await _dio.post('/rebate/update/$id', data: {"status": status});

    if (response.statusCode == 200) {
      print('Rebate status updated successfully');
    } else {
      print('Failed to update status of rebate');
    }
  }

  Future<void> handleApproval(Rebate data) async {
    await updateRebateStatus(data.id, RebateStatus.APPROVED.toString());
  }

  Future<void> handleRejection(Rebate data) async {
    await updateRebateStatus(data.id, RebateStatus.REJECTED.toString());
  }
}
