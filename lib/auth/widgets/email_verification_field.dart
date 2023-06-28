import 'package:dlsm_web/common/index.dart';




class EmailVerificationField extends StatelessWidget {

  const EmailVerificationField({
    super.key,
    required TextEditingController emailController,
  }) : _emailController = emailController;

  final TextEditingController _emailController;



  @override
  Widget build(BuildContext context) {
    return <Widget>[
      const Text(
        'EMAIL ADDRESS',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
      <Widget>[
        // const _buildCountryCodeSelector(),
        const _Icon(),

        SizedBox(width: MediaQuery.of(context).size.width * 0.03),

        SizedBox(width: MediaQuery.of(context).size.width * 0.03),
        Expanded(
          child: _EmailInputField(emailController: _emailController),
        )
      ].toRow(),
    ].toColumn(crossAxisAlignment: CrossAxisAlignment.start);
  }
}

class _Icon extends StatelessWidget {
  const _Icon();

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.email,
      color: Colors.blueGrey,
      size: 30.0,
    );
  }
}

class _EmailInputField extends StatelessWidget {
  const _EmailInputField({
    required TextEditingController emailController,
  }) : _emailController = emailController;

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        controller: _emailController,
        hintText: "Email Address",
      );
  }
}
