
import 'package:dlsm_web/app/index.dart';
import 'package:dlsm_web/common/index.dart';



final resetPasswordTokenStateProvider = StateNotifierProvider<ResetPasswordTokenStateNotifier, ResetPasswordTokenState>(
  (ref) => ResetPasswordTokenStateNotifier(ref)
);


typedef ResetPasswordTokenState = String?;




class ResetPasswordTokenStateNotifier extends RiverpodStateNotifier<ResetPasswordTokenState> {

  ResetPasswordTokenStateNotifier(StateNotifierProviderRef ref) 
    :super(null, ref);


  void setToken(String? resetPasswordToken) async {
    state = resetPasswordToken;
  }
}
