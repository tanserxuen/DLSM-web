
// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../auth/index.dart';
import '../../app/index.dart';
import '../services/logger_service.dart';
import '../services/dio_service.dart';


/// Although reading the riverpod container directly is not recommended, it is the easiest way
/// to get the current state.
///
/// This interceptor automatically try to refresh the access token if there is a refresh token.
class RefreshTokenInterceptor extends Interceptor {
  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (
      err.response == null ||
      err.response!.statusCode != 401 ||
      err.response!.data == null ||
      err.response!.data['error'] == null ||
      err.response!.data['error'] != 'jwt expired'
    ) return handler.next(err);

    Logger logger = riverpodContainer.read(loggerServiceProvider);
    logger.i('Refresh token interceptor - Refreshing access token');

    AuthTokensState tokens = riverpodContainer.read(authTokensStateProvider);
    if (tokens.refreshToken == null) return handler.next(err);

    RequestOptions options = err.requestOptions;
    Dio dio = riverpodContainer.read(dioServiceProvider).backendDio;

    try {
      // Refresh the access token and refresh token
      AuthService authService = riverpodContainer.read(authServiceProvider);
      await authService.renewTokens();

      tokens = riverpodContainer.read(authTokensStateProvider);

      // Retry the original request with the new access token. Be careful here because the old request 
      // options contains the old access token.
      options.headers['Authorization'] = 'Bearer ${tokens.accessToken}';
      Response res = await dio.fetch(options);
      handler.resolve(res);
    } 
    on DioError catch (error) {
      handler.reject(error);
    }
  }
}