
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dlsm_web/app/index.dart';
import 'package:dlsm_web/common/index.dart';





final snackBarServiceProvider = Provider<SnackBarService>((ref) => SnackBarService(ref));



class SnackBarService extends RiverpodService {

  SnackBarService(ProviderRef ref) : super(ref);

  void showSuccess(String title, [String message = ""]) {
    SnackBar snackBar = _getSnackbar(ContentType.success, title, message);
    _showSnackbar(snackBar);
  }

  void showWarning(String title, [String message = ""]) {
    SnackBar snackBar = _getSnackbar(ContentType.warning, title, message);
    _showSnackbar(snackBar);
  }

  void showFailure(String title, [String message = ""]) {
    SnackBar snackBar = _getSnackbar(ContentType.failure, title, message);
    _showSnackbar(snackBar);
  }

  void showInfo(String title, [String message = ""]) {
    SnackBar snackBar = _getSnackbar(ContentType.help, title, message);
    _showSnackbar(snackBar);
  }
  


  SnackBar _getSnackbar(ContentType contentType, String title, String message) {
    final content = AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: contentType,
    );

    return SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      padding: const EdgeInsets.only(top: 10),
      content: content,
    );
  }


  void _showSnackbar(SnackBar snackBar) {
    scaffoldMessenger
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
