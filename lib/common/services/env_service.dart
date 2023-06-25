
import 'package:dlsm_web/app/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

import './logger_service.dart';



final envServiceProvider = Provider<EnvService>((ref) => EnvService(ref));



class EnvService extends RiverpodService {
  
  static const String _envPath = '.env';

  Logger get _logger => ref.read(loggerServiceProvider);


  EnvService(ProviderRef ref) : super(ref);

  Future<bool> get isInitialized async => dotenv.isInitialized;


  String getEnv(String key) {
    if (dotenv.env.containsKey(key)) return dotenv.env[key]!;
    throw Exception('Env key $key not found');
  }


  Future<void> initializeEnv() async {
    await dotenv.load(fileName: _envPath);
    _logger.i('Env initialized');
  }
}
