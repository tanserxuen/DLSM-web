
import 'package:dlsm_web/app/index.dart';
import 'package:dlsm_web/common/index.dart';



final authTokensStateProvider = StateNotifierProvider<AuthTokensStateNotifier, AuthTokensState>(
  (ref) => AuthTokensStateNotifier(ref)
);


@immutable
class AuthTokensState {
  final String? accessToken;
  final String? refreshToken;

  const AuthTokensState({this.accessToken, this.refreshToken});
}




class AuthTokensStateNotifier extends RiverpodStateNotifier<AuthTokensState> {

  AuthTokensStateNotifier(StateNotifierProviderRef ref) 
    :super( const AuthTokensState(), ref);


  void setTokens(String? accessToken, String? refreshToken) {
    state = AuthTokensState(accessToken: accessToken, refreshToken: refreshToken);
  }
}
