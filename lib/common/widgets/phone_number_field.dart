
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import './custom_textfield.dart';


class PhoneNumberField extends StatelessWidget {

  final TextEditingController _phoneController;

  
  const PhoneNumberField({
    super.key,
    required TextEditingController phoneController,
  }) : _phoneController = phoneController;


  @override
  Widget build(BuildContext context) {
    final Text label = const Text('PHONE NUMBER').fontSize(13).fontWeight(FontWeight.bold);

    final Row field = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const _CountryCodeSelector(),
        const SizedBox(width: 10),
        const Text('+60').fontSize(13),
        const SizedBox(width: 10),
        Expanded(child: _PhoneInputField(phoneController: _phoneController))
      ],
    );

    return [ label, field ].toColumn(crossAxisAlignment: CrossAxisAlignment.start);
  }
}


class _CountryCodeSelector extends StatelessWidget {
  const _CountryCodeSelector();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: Image.asset('assets/imgs/malaysia_flag.png'),
    );
  }
}


class _PhoneInputField extends StatelessWidget {
  const _PhoneInputField({
    required TextEditingController phoneController,
  }) : _phoneController = phoneController;

  final TextEditingController _phoneController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: _phoneController,
      hintText: "Phone Number",
      isNumberOnly: true
    );
  }
}
