
import 'package:dlsm_web/admin/auth/index.dart';
import 'package:dlsm_web/app/index.dart';
import 'package:dlsm_web/common/index.dart';

import '../dto/index.dart';
import '../states/user_state.dart';
import '../model/user.dart';




final userServiceProvider = Provider<UserService>((ref) => UserService(ref));



class UserService extends RiverpodService {

  Dio get _dio => ref.read(dioServiceProvider).backendDio;

  UserStateNotifier get _userStateNotifier => ref.read(userStateProvider.notifier);
  AuthTokensState get _authTokensState => ref.read(authTokensStateProvider);
  AuthTokensStateNotifier get _authTokensStateNotifier => ref.read(authTokensStateProvider.notifier);
  RefreshTokenHiveService get _refreshTokenHiveService => ref.read(refreshTokenHiveServiceProvider);

  UserService(ProviderRef ref) : super(ref);


  Future<User> getUser() async {
    AuthTokensState state = _authTokensState;
    if (state.accessToken == null) throw Exception('Not authenticated. Access token is null');

    _userStateNotifier.setLoading();

    try {
      Response response = await _dio.get('/user/profile');
      UserResponseDTO dto = UserResponseDTO.fromJson(response.data);
      User user = dto.toUser();
      _userStateNotifier.setUser(user);
      return user;
    } catch (error) {
      _userStateNotifier.revertToPreviousState();
      rethrow;
    }
  }


  Future<User> updateUser(UpdateUserRequestDto dto) async {
    AuthTokensState state = _authTokensState;
    if (state.accessToken == null) throw Exception('Not authenticated. Access token is null');

    _userStateNotifier.setLoading();

    try {
      Response response = await _dio.patch(
        '/user/update',
        data: dto.toJson(),
      );
      UserResponseDTO userResponseDTO = UserResponseDTO.fromJson(response.data);
      User user = userResponseDTO.toUser();
      _userStateNotifier.setUser(user);
      return user;
    } catch (error) {
      _userStateNotifier.revertToPreviousState();
      rethrow;
    }

  }


  Future<void> deleteUser() async {
    AuthTokensState state = _authTokensState;
    if (state.accessToken == null) throw Exception('Not authenticated. Access token is null');

    _userStateNotifier.setLoading();

    try {
      await _dio.delete('/user/delete');
      _userStateNotifier.setUser(null);
      _authTokensStateNotifier.setTokens(null, null);
      await _refreshTokenHiveService.clearRefreshToken();
    } catch (error) {
      _userStateNotifier.revertToPreviousState();
      rethrow;
    }
  }
}