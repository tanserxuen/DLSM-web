



import '../../admin/auth/index.dart';
import '../../app/index.dart';
import '../index.dart';

/// Although reading the riverpod container directly is not recommended, it is the easiest way
/// to get the current state.
///
/// This interceptor automatically adds the access token to the request header if the user is
/// authenticated, otherwise it does nothing.
/// 
/// Conditions for adding the access token:
///  1. access_token is not null.
///  2. The header does not contain the Authorization key yet.
class AccessTokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AuthTokensState tokens = riverpodContainer.read(authTokensStateProvider);
    if (
      tokens.accessToken == null ||
      options.headers.containsKey("Authorization")
    ) return handler.next(options);

    options.headers['Authorization'] = 'Bearer ${tokens.accessToken}';
    return handler.next(options);
  }
}