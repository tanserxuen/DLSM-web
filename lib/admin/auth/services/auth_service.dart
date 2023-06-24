import 'package:dlsm/app/index.dart';
import 'package:dlsm/common/index.dart';

import '../dtos/index.dart';
import '../states/auth_tokens_state.dart';
import './refresh_token_hive_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService(ref));

class AuthService extends RiverpodService {
  Dio get _dio => ref.read(dioServiceProvider).backendDio;

  AuthTokensStateNotifier get _authTokensStateNotifier =>
      ref.read(authTokensStateProvider.notifier);
  ResetPasswordTokenStateNotifier get _resetPasswordTokenStateNotifier =>
      ref.read(resetPasswordTokenStateProvider.notifier);
  RefreshTokenHiveService get _refreshTokenHiveService =>
      ref.read(refreshTokenHiveServiceProvider);

  AuthTokensState get _authTokensState => ref.read(authTokensStateProvider);
  ResetPasswordTokenState get _resetPasswordTokenState =>
      ref.read(resetPasswordTokenStateProvider);

  AuthService(ProviderRef ref) : super(ref);

  Future<void> signIn(SignInRequestDTO dto) async {
    if (_authTokensState.accessToken != null)
      throw Exception('Already authenticated. Access token is not null');

    Response response = await _dio.post('auth/signin', data: dto.toJson());
    AuthTokensResponseDTO tokens =
        AuthTokensResponseDTO.fromJson(response.data);
    await _refreshTokenHiveService.setRefreshToken(tokens.refreshToken);
    _authTokensStateNotifier.setTokens(tokens.accessToken, tokens.refreshToken);
  }

  Future<void> signUp(SignUpRequestDTO dto) async {
    if (_authTokensState.accessToken != null)
      throw Exception('Already authenticated. Access token is not null');

    Response response = await _dio.post('auth/signup', data: dto.toJson());
    AuthTokensResponseDTO tokens =
        AuthTokensResponseDTO.fromJson(response.data);
    await _refreshTokenHiveService.setRefreshToken(tokens.refreshToken);
    _authTokensStateNotifier.setTokens(tokens.accessToken, tokens.refreshToken);
  }

  Future<void> signOut() async {
    AuthTokensState state = _authTokensState;
    if (state.accessToken == null)
      throw Exception('Not authenticated. Access token is null');

    await _dio.post('auth/signout');

    await _refreshTokenHiveService.clearRefreshToken();
    _authTokensStateNotifier.setTokens(null, null);
  }

  Future<void> renewTokens() async {
    AuthTokensState state = _authTokensState;
    if (state.refreshToken == null)
      throw Exception('Not authenticated. Refresh token is null');

    Response response = await _dio.post('auth/refresh',
        options: Options(
            headers: {'Authorization': 'Bearer ${state.refreshToken}'}));
    AuthTokensResponseDTO tokens =
        AuthTokensResponseDTO.fromJson(response.data);
    await _refreshTokenHiveService.setRefreshToken(tokens.refreshToken);
    _authTokensStateNotifier.setTokens(tokens.accessToken, tokens.refreshToken);
  }
}
