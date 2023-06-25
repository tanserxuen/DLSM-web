import 'package:dlsm_web/admin/model/rebate.dart';
import 'package:dlsm_web/admin/services/rebate_service.dart';
import 'package:dlsm_web/admin/states/participant_record_state.dart';
import 'package:dlsm_web/app/index.dart';
import 'package:dlsm_web/common/index.dart';

final rebateListStateProvider =
    StateNotifierProvider<RebateListStateNotifier, RebateListState>(
        (ref) => RebateListStateNotifier(ref));

class RebateListState {
  final List<Rebate>? rebateList;

  bool isLoading;
  RebateListState({this.rebateList, this.isLoading = true});
}

class RebateListStateNotifier extends RiverpodStateNotifier<RebateListState> {
  RebateListStateNotifier(StateNotifierProviderRef ref)
      : super(RebateListState(), ref);

  ParticipantRecordStateNotifier get _participantRecordStateNotifier =>
      ref.read(participantRecordStateProvider.notifier);
  RebateService get _rebateService => ref.read(rebateServiceProvider);

  void setIsLoading(bool isLoading) {
    state = RebateListState(isLoading: isLoading);
  }

  void setRebateList(List<Rebate> rebateList) {
    state = RebateListState(rebateList: rebateList, isLoading: false);

    // rebateList.forEach((rebate) async {
    //   final participantRecord = await _rebateService.fetchParticipantRecord(
    //       rebate.user, rebate.campaign);
    //   _participantRecordStateNotifier.setParticipantRecord(participantRecord);
    // });
  }
}
