import 'package:dlsm_web/app/index.dart';
import 'package:dlsm_web/common/index.dart';
import 'package:dlsm_web/user/dto/index.dart';

final userListStateProvider =
    StateNotifierProvider<UserListStateNotifier, UserListState>(
        (ref) => UserListStateNotifier(ref));

class UserListState {
  final List<UserResponseDTO>? userList;
  bool isLoading;
  UserListState({this.userList, this.isLoading = true});
}

class UserListStateNotifier extends RiverpodStateNotifier<UserListState> {
  UserListStateNotifier(StateNotifierProviderRef ref)
      : super(UserListState(userList: []), ref);

  void setUserList(List<UserResponseDTO> userList) {
    state = UserListState(userList: userList, isLoading: false);
  }
}
