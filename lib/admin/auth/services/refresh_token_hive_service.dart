import 'package:dlsm/app/index.dart';
import 'package:dlsm/common/index.dart';

final refreshTokenHiveServiceProvider =
    Provider<RefreshTokenHiveService>((ref) => RefreshTokenHiveService(ref));

const String _key = 'refreshToken';

typedef RefreshTokenBoxValue = String?;
typedef RefreshTokenBox = Box<RefreshTokenBoxValue>;

class RefreshTokenHiveService extends RiverpodService {
  RefreshTokenBox? _refreshTokenBox;

  Future<RefreshTokenBox> get _getRefreshTokenBox async {
    _refreshTokenBox ??=
        await Hive.openBox<RefreshTokenBoxValue>('refreshTokenBox');
    return _refreshTokenBox!;
  }

  RefreshTokenHiveService(ProviderRef ref) : super(ref);

  Future<RefreshTokenBoxValue> getRefreshToken() async {
    final refreshTokenBox = await _getRefreshTokenBox;
    return refreshTokenBox.get(_key);
  }

  Future<void> setRefreshToken(String refreshToken) async {
    final refreshTokenBox = await _getRefreshTokenBox;
    await refreshTokenBox.put(_key, refreshToken);
  }

  Future<void> clearRefreshToken() async {
    final refreshTokenBox = await _getRefreshTokenBox;
    await refreshTokenBox.clear();
  }
}
