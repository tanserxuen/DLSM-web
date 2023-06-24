

import 'package:dlsm_web/admin/auth/index.dart';
import 'package:dlsm_web/admin/user/index.dart';
import 'package:dlsm_web/app/index.dart';
import 'package:dlsm_web/common/index.dart';





class InitPage extends ConsumerStatefulWidget {
  const InitPage({super.key});
  @override ConsumerState<InitPage> createState() => _InitPageState();
}


class _InitPageState extends ConsumerState<InitPage> {

  Logger get _logger => ref.read(loggerServiceProvider);
  SnackBarService get _snackBarService => ref.read(snackBarServiceProvider);
  AuthService get _authService => ref.read(authServiceProvider);
  UserService get _userService => ref.read(userServiceProvider);
  RefreshTokenHiveService get _refreshTokenHiveService => ref.read(refreshTokenHiveServiceProvider);
  AuthTokensStateNotifier get _authTokensStateNotifier => ref.read(authTokensStateProvider.notifier);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_)=> initializeApplication());
  }


  void initializeApplication() async {
    String? refreshToken = await _refreshTokenHiveService.getRefreshToken();
    
    // No refresh token stored persistently, go to sign in page
    if (refreshToken == null) {
      navigator.pushReplacementNamed(Routes.signInPage);
      return;
    }

    // Otherwise get a new pair of access and refresh token, as well as the user
    try {
      _authTokensStateNotifier.setTokens(null, refreshToken);
      await _authService.renewTokens();
      await _userService.getUser();

      // If everything went well, go to dashboard
      navigator.pushReplacementNamed(Routes.homePage);
      _snackBarService.showSuccess("Logged in successfully", "Welcome back!");
    }
    // If something went wrong, go to sign in page and clear the faulty refresh token
    catch (error) {
      await _refreshTokenHiveService.clearRefreshToken();
      _authTokensStateNotifier.setTokens(null, null);
      _snackBarService.showInfo("You have been logged out", "Please sign in again");
      navigator.pushReplacementNamed(Routes.signInPage);
      _logger.e(error);
    }
  }



  @override
  Widget build(BuildContext context) {
    return const LoadingPage();
  }
}
