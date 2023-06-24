import 'package:dlsm_web/app/index.dart';
import 'package:dlsm_web/common/index.dart';

import '../model/user.dart';


typedef UserState = AsyncValue<User?>;

// Stores the previous user before the state being set to loading or error, so that
// we can use it to restore the state 
User? _previousUser;

final userStateProvider = StateNotifierProvider<UserStateNotifier, UserState>(
  (ref) => UserStateNotifier(ref)
);




class UserStateNotifier extends RiverpodStateNotifier<UserState> {

  UserStateNotifier(StateNotifierProviderRef ref) 
    :super( const AsyncValue.data(null), ref);


  void setUser(User? user) {
    state = AsyncValue.data(user);
    _previousUser = user ?? _previousUser;
  }

  void setLoading() {
    state = const AsyncValue.loading();
  }

  void setError(Exception error, StackTrace stackTrace) {
    state = AsyncValue.error(error, stackTrace);
  }

  void revertToPreviousState() {
    state = AsyncValue.data(_previousUser);
  }
}
