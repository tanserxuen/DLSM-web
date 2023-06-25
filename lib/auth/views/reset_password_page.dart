


// ignore_for_file: deprecated_member_use

import 'package:dlsm_web/auth/index.dart';
import 'package:dlsm_web/auth/widgets/email_verification_field.dart';
import 'package:dlsm_web/app/index.dart';
import 'package:dlsm_web/common/index.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {
  const ResetPasswordPage({ super.key });
  @override ConsumerState<ResetPasswordPage> createState() => _ResetPasswordView();
}



class _ResetPasswordView extends ConsumerState<ResetPasswordPage> {

  bool isSent = false;
  final TextEditingController _emailController = TextEditingController();

  Logger get _logger => ref.read(loggerServiceProvider);
  SnackBarService get _snackBarService => ref.read(snackBarServiceProvider);
  AuthService get _authService => ref.read(authServiceProvider);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: MediaQuery.of(context).size.width * 0.4,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        leading: FittedBox(
          child: Image.asset('assets/imgs/logo_title.png', fit: BoxFit.cover)
        ).padding(left: 30, top: 10),
        actions: [
          IconButton(
            onPressed: () => navigator.pop(),
            icon: const Icon(Icons.close),
            color: CustomTheme.activeTheme.primaryColor,
          ).paddingDirectional(end: MediaQuery.of(context).size.width * 0.05)
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          const Text(
            'Reset Password',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text("The verification code will be sent to your email")
            .padding(bottom: MediaQuery.of(context).size.height * 0.05),
          EmailVerificationField(emailController: _emailController),
          const SizedBox(height: 20),
          CustomElevatedButton(
            label: "Send Verification Code",
            onPressed: () => sendVerificationCode(context),
            theme: CustomTheme.activeTheme,
          ),
        ],
      ),
    );
  }



  void sendVerificationCode(BuildContext context) async {
    final String emailAddress = _emailController.text;

    // Validate email address
    bool isValid = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailAddress);
    if (!isValid) {
      _snackBarService.showFailure("Invalid Email Address, Please enter correct email address");
      return;
    }

    navigator.pushNamed(Routes.loadingPage);
    RequestResetPasswordRequestDTO requestResetPasswordRequestDTO = RequestResetPasswordRequestDTO(email: emailAddress);

    try {
      await _authService.requestResetPassword(requestResetPasswordRequestDTO);

      navigator.pop();
      _snackBarService.showSuccess("Success", "Verification code has been sent to your email address");
      navigator.pushNamed(Routes.verificationCodePage, arguments: emailAddress);
    } 
    catch (error) {
      navigator.pop();

      if (error is DioError) {
        _logger.e(error.response?.data ?? error);
        _snackBarService.showFailure("Request to reset password failed", error.response?.data['message'].toString() ?? error.toString());
      } else {
        _logger.e(error);
        _snackBarService.showFailure("Unexpected error", error.toString());
      }
    }
  }
}
