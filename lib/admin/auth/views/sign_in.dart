import 'package:flutter/material.dart';

import '../widgets/sign_in_form.dart';

class SignInPage extends StatefulWidget {
  static const routeName = '/sign-in';

  const SignInPage({super.key});
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return const ViewSignInLayout();
  }
}

class ViewSignInLayout extends StatelessWidget {
  const ViewSignInLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: const BouncingScrollPhysics(),
          child: const SafeArea(
            child: SignInForm(),
          ).padding(all: MediaQuery.of(context).size.width * 0.1),
        ),
      ),
    );
  }
}
