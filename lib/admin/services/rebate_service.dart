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

  Future<List<Rebate>> fetchAllData() async {
    _rebateListStateNotifier.setIsLoading(true);
    final response = await _dio.get('/rebate/rebate-list');
    // print(response.data);
    final data = response.data as List<dynamic>;
    final List<Rebate> dataList = data.map((e) => Rebate.fromJson(e)).toList();
    _logger.i(dataList);
    return dataList;
  }

  // fetch participant record
  Future<List<ParticipantRecord>> fetchParticipantRecord() async {
    final response = await _dio.get('/campaign/records/previous');
    final data = response.data as List<dynamic>;
    print(data);
    final List<ParticipantRecord> dataList =
        data.map((e) => ParticipantRecord.fromJson(e)).toList();
    _logger.i(dataList);
    return dataList;
  }

  // fetch all approved rebate records for mileage-reduction
  Future<List<Rebate>> fetchApprovedMileageReduction() async {
    final response = await _dio.get('/rebate/previous/mileage-reduction');
    final data = response.data as List<dynamic>;
    final List<Rebate> dataList = data.map((e) => Rebate.fromJson(e)).toList();
    _logger.i(dataList);
    return dataList;
  }

  // fetch all approved rebate records for safe-driver
  Future<List<Rebate>> fetchApprovedSafeDriver() async {
    final response = await _dio.get('/rebate/previous/safe-driver');
    final data = response.data as List<dynamic>;
    final List<Rebate> dataList = data.map((e) => Rebate.fromJson(e)).toList();
    _logger.i(dataList);
    return dataList;
  }

  // return the number of previous rebate records for approved
  Future<int> numOfPreviousApprovedRebate() async {
    _rebateListStateNotifier.setIsLoading(true);
    final response = await _dio.get('/rebate/rebate-list');
    // print(response.data);
    final data = response.data as List<dynamic>;
    final List<Rebate> dataList = data
        .map((e) => Rebate.fromJson(e))
        .where((rebate) => rebate.status == "APPROVED")
        .toList();
    _logger.i(dataList);
    _rebateListStateNotifier.setRebateList(dataList);
    print(dataList.length.toInt());
    return dataList.length.toInt();
  }

  // return the number of previous rebate records for safe-driver (approved)
  Future<int> numOfPreviousApprovedSafeDriver() async {
    _rebateListStateNotifier.setIsLoading(true);
    final response = await _dio.get('/rebate/previous/safe-driver');
    final data = response.data as List<dynamic>;
    final List<Rebate> dataList = data.map((e) => Rebate.fromJson(e)).toList();
    // print number
    print(dataList.length.toInt());
    return dataList.length.toInt();
  }

  // return the number of previous rebate records for mileage-reduction (approved)
  Future<int> numOfPreviousApprovedMileageReduction() async {
    _rebateListStateNotifier.setIsLoading(true);
    final response = await _dio.get('/rebate/previous/mileage-reduction');
    final data = response.data as List<dynamic>;
    final List<Rebate> dataList = data.map((e) => Rebate.fromJson(e)).toList();
    return dataList.length.toInt();
  }

  // update status of rebate
  Future<void> updateRebateStatus(String id, String status) async {
    final response =
        await _dio.post('/rebate/update-status/$id', data: {"status": status});

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
