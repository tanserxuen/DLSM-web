// ignore_for_file: deprecated_member_use

import 'package:dlsm_web/app/index.dart';
import 'package:dlsm_web/common/index.dart';

import './sign_in.dart';
import '../dtos/index.dart';
import '../services/auth_service.dart';


class VerificationCode extends ConsumerStatefulWidget {
  static const routeName = '/verification-code-passcode';

  const VerificationCode({super.key});
  @override ConsumerState<VerificationCode> createState() => _VerificationCodeState();
}




class _VerificationCodeState extends ConsumerState<VerificationCode> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  final TextEditingController _verificationController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  late String verificationCode;
  late String password;
  late String rePassword;

  AuthService get _authService => ref.read(authServiceProvider);
  SnackBarService get _snackBarService => ref.read(snackBarServiceProvider);
  Logger get _logger => ref.read(loggerServiceProvider);

  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)!.settings.arguments as String;


    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: FittedBox(
                  child: Image.asset('assets/imgs/logo_title.png',
                      fit: BoxFit.cover))
              .padding(left: 30, top: 10),
          leadingWidth: MediaQuery.of(context).size.width * 0.4,
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          actions: [
            IconButton(
              onPressed: () => navigator.pop(),
              icon: const Icon(Icons.close),
              color: CustomTheme.activeTheme.primaryColor,
            ).paddingDirectional(end: MediaQuery.of(context).size.width * 0.05)
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 25),
            const Text(
              'Reset your password ',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ).padding(bottom: 10),
            Text(
              'Please check your email: $email',
            ).fontSize(15),
            inputVerificationCode(),
            inputPassword(),
            inputRePassword(),
            confirmPassword(context)
              .toColumn(mainAxisSize: MainAxisSize.min)
              .padding(vertical: MediaQuery.of(context).size.height * 0.05),
          ],
        ).safeArea(),
      ),
    );
  }

  CustomFormField inputVerificationCode() {
    return CustomFormField(
      prefixIcon: const Icon(Icons.verified_user_sharp),
      labelText: 'Verification Code',
      hintText: 'Enter your Verification Code',
      controller: _verificationController,
      validator: (value) {
        if (!value!.isValidName) return 'Incorrect code';
        return null;
      },
      onChanged: (value) {
        setState(() {
          verificationCode = value;
        });
      },
    );
  }

  CustomFormField inputPassword() {
    return CustomFormField(
      obscureText: _obscureText1,
      prefixIcon: const Icon(Icons.password_sharp),
      labelText: 'Password',
      hintText: 'Enter your Password',
      controller: _passwordController,
      suffixIcon: IconButton(
        icon: Icon(_obscureText1 ? Icons.visibility_off : Icons.visibility),
        onPressed: () {
          setState(
            () {
              _obscureText1 = !_obscureText1;
            },
          );
        },
      ),
      validator: (value) {
        if (!value!.isValidName) return 'Enter valid Password';
        return null;
      },
      onChanged: (value) {
        setState(() {
          password = value;
        });
      },
    );
  }

  CustomFormField inputRePassword() {
    return CustomFormField(
      obscureText: _obscureText2,
      prefixIcon: const Icon(Icons.confirmation_num_sharp),
      labelText: 'Confirm Password',
      hintText: 'Confirm your Password',
      controller: _rePasswordController,
      suffixIcon: IconButton(
        icon: Icon(_obscureText2 ? Icons.visibility_off : Icons.visibility),
        onPressed: () {
          setState(
            () {
              _obscureText2 = !_obscureText2;
            },
          );
        },
      ),
      validator: (value) {
        if (!value!.isValidName) return 'Enter valid Password';
        return null;
      },
      onChanged: (value) {
        setState(() {
          rePassword = value;
        });
      },
    );
  }

  void startContinue() async {
    final String verification = _verificationController.text;

    if (verification.isEmpty || password.isEmpty) {
      _snackBarService.showWarning("The password field must be entered");
    } else if (password != rePassword) {
      _snackBarService.showWarning("Passwords do not match");
    } else {
      ResetPasswordRequestDTO resetPasswordRequestDTO = ResetPasswordRequestDTO(
        code: verificationCode, 
        newPassword: password
      );

      navigator.pushNamed(Routes.loadingPage);

      try {
        await _authService.resetPassword(resetPasswordRequestDTO);

        _snackBarService.showSuccess("Password changed successfully", "Please sign in with your new password");
        navigator.pushNamedAndRemoveUntil(SignInPage.routeName, (route) => false);
      }
      catch (error) {
        navigator.pushNamedAndRemoveUntil(SignInPage.routeName, (route) => false);

        if (error is DioError) {
          _logger.e(error.response?.data ?? error);
          _snackBarService.showFailure("Reset password failed", error.response?.data['message'].toString() ?? error.toString());
        } else {
          _logger.e(error);
          _snackBarService.showFailure("Unexpected error", error.toString());
        }
      }
    }
  }

  List<Widget> confirmPassword(BuildContext context) {
    return <Widget>[
      SizedBox(
          child: <Widget>[
        Expanded(
          child: CustomElevatedButton(
            label: "CONFIRM",
            onPressed: startContinue,
            theme: CustomTheme.activeTheme,
          ).padding(top: 15),
        ),
      ].toRow(mainAxisAlignment: MainAxisAlignment.center)),
    ];
  }

}
