import 'package:dlsm_web/admin/model/participantRecord.dart';
import 'package:dlsm_web/admin/model/rebate.dart';
import 'package:dlsm_web/app/index.dart';
import 'package:dlsm_web/common/index.dart';

final participantRecordStateProvider = StateNotifierProvider<
    ParticipantRecordStateNotifier,
    ParticipantRecordState>((ref) => ParticipantRecordStateNotifier(ref));

class ParticipantRecordState {
  final List<ParticipantRecord>? participantRecord;

  bool isLoading;
  ParticipantRecordState({this.participantRecord, this.isLoading = true});
}

class ParticipantRecordStateNotifier
    extends RiverpodStateNotifier<ParticipantRecordState> {
  ParticipantRecordStateNotifier(StateNotifierProviderRef ref)
      : super(ParticipantRecordState(), ref);

  void setParticipantRecord(List<ParticipantRecord> participantRecord) {
    state = ParticipantRecordState(
        participantRecord: participantRecord, isLoading: false);
  }
}
