// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:dlsm_web/admin/states/user_list_state.dart';
import 'package:dlsm_web/app/index.dart';
import 'package:dlsm_web/common/index.dart';
import 'package:dlsm_web/user/dto/index.dart';
import 'package:universal_html/html.dart' as html;

final userProfileServiceProvider = Provider<UserProfileService>(
  (ref) => UserProfileService(ref),
);

class UserProfileService extends RiverpodService {
  //Constructor
  UserProfileService(ProviderRef ref) : super(ref);
  Logger get _logger => ref.read(loggerServiceProvider);
  List userList = [];
  Dio get _dio => ref.read(dioServiceProvider).backendDio;
  Dio get _reportGenerationDio =>
      ref.read(dioServiceProvider).reportGenerationDio;
  UserListStateNotifier get _userStateNotifier =>
      ref.read(userListStateProvider.notifier);

  List<UserResponseDTO> userResponseDTO = [];

  Future<void> getData() async {
    try {
      Response response = await _dio.get(
        'admin/dashboard',
      );
      for (var i = 0; i < response.data.length; i++) {
        userResponseDTO.add(UserResponseDTO.fromJson(response.data[i]));
      }
      _userStateNotifier.setUserList(userResponseDTO);
    } catch (e) {
      _logger.e(e);
    }
  }

}
