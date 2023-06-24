
import 'package:dio/dio.dart';
import 'package:dlsm_web/app/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../interceptors/access_token_interceptor.dart';
import '../interceptors/refresh_token_interceptor.dart';
import './env_service.dart';


final dioServiceProvider = Provider<DioService>((ref) => DioService(ref));



class DioService extends RiverpodService {

  Dio? _backendDio;
  Dio? _dio;

  EnvService get _envService => ref.read(envServiceProvider);

  Dio get dio {
    if (_dio != null) return _dio!;

    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(seconds: 10),
    );

    _dio = Dio(options);
    return _dio!;
  }

  Dio get  backendDio {
    if (_backendDio != null) return _backendDio!;

    BaseOptions options = BaseOptions(
      baseUrl: _envService.getEnv('BACKEND_URL'),
      connectTimeout: const Duration(seconds: 20),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    _backendDio = Dio(options);

    // Register interceptors
    _backendDio!.interceptors.add(AccessTokenInterceptor());
    _backendDio!.interceptors.add(RefreshTokenInterceptor());

    return _backendDio!;
  }


  DioService(ProviderRef ref) : super(ref);
}
