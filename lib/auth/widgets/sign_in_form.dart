// ignore_for_file: deprecated_member_use

import 'package:dlsm_web/user/index.dart';
import 'package:dlsm_web/app/index.dart';
import 'package:dlsm_web/common/index.dart';

import '../dtos/index.dart';
import '../services/auth_service.dart';

class SignInForm extends ConsumerStatefulWidget {
  const SignInForm({super.key});
  @override
  ConsumerState<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends ConsumerState<SignInForm> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AuthService get _authService => ref.read(authServiceProvider);
  UserService get _userService => ref.read(userServiceProvider);
  SnackBarService get _snackBarService => ref.read(snackBarServiceProvider);
  Logger get _logger => ref.read(loggerServiceProvider);

  void login(BuildContext context, String phoneNumber, String password) async {
    if (_passwordController.text.isEmpty || _phoneController.text.isEmpty) {
      _snackBarService.showFailure("Please complete your sign in detail");
      return;
    }

    navigator.pushNamed(Routes.loadingPage);

    SignInRequestDTO signInRequestDTO = SignInRequestDTO(
        phoneNumber: _phoneController.text, password: _passwordController.text);

    try {
      await _authService.signIn(signInRequestDTO);
      await _userService.getUser();

      _snackBarService.showSuccess("Sign in successful", "Welcome back.");
      navigator.pushNamedAndRemoveUntil(Routes.homePage, (route) => false);
    } catch (error) {
      navigator.pop();

      if (error is DioError) {
        _logger.e(error.response?.data ?? error);
        _snackBarService.showFailure("Sign in failed",
            error.response?.data['message'].toString() ?? error.toString());
      } else {
        _logger.e(error);
        _snackBarService.showFailure("Unexpected error", error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      const DLSMLogo(),
      const SizedBox(height: 35),
      const Text(
        'Sign In',
      ).fontSize(30).fontWeight(FontWeight.bold),
      const SizedBox(height: 25),
      PhoneNumberField(phoneController: _phoneController),
      const SizedBox(height: 25),
      const Text('PASSWORD').fontSize(13).fontWeight(FontWeight.bold),
      inputPassword(),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomElevatedButton(
              theme: CustomTheme.invisibleTheme,
              textSize: 10,
              color: Colors.black,
              onPressed: () => navigator.pushNamed(Routes.resetPasswordPage),
              label: "Reset Passcode")
        ],
      ),
      const SizedBox(height: 25),
      CustomElevatedButton(
        label: "LOGIN",
        theme: CustomTheme.activeTheme,
        onPressed: () =>
            login(context, _phoneController.text, _passwordController.text),
      ).width(double.infinity),
      const SizedBox(height: 25),
      Text("Version 1.0.0 + BETA",
              style: TextStyle(
                  fontSize: CustomTheme
                      .descriptionTheme.textTheme.displaySmall?.fontSize))
          .center(widthFactor: MediaQuery.of(context).size.width * 0.5),
      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
    ].toColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max);
  }

  CustomFormField inputPassword() {
    return CustomFormField(
      labelText: 'Password',
      hintText: 'Enter your password',
      controller: _passwordController,
      validator: (value) {
        if (value!.length < 6) return 'Password must be at least 6 characters';
        return null;
      },
    );
  }
}
