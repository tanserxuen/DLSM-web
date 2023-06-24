import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';


class CustomFormField extends StatelessWidget {

  final String hintText;
  final String? labelText;
  final bool isdisabled;
  final String? initialValue;
  final Widget? prefixIcon;
  final InputBorder? border;
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;


  const CustomFormField({
    Key? key,
    this.labelText,
    required this.hintText,
    this.controller,
    this.validator,
    this.onChanged,
    this.border,
    this.prefixIcon,
    this.suffixIcon,
    this.isdisabled = false,
    this.obscureText = false, 
    this.initialValue,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return <Widget>[
      TextFormField(
        initialValue: initialValue,
        obscureText: obscureText!,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          border: border,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: labelText,
          hintText: hintText,
          floatingLabelBehavior: !isdisabled
              ? FloatingLabelBehavior.never
              : FloatingLabelBehavior.always,
        ),
        onChanged: onChanged,
        readOnly: isdisabled,
      ),
    ].toColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
    ).padding(vertical: 5);
  }
}




extension ExtString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp = RegExp('[a-zA-Z]');
    return nameRegExp.hasMatch(this);
  }

  bool get isValidId {
    Pattern pattern = r'^[0-9]{10,20}$';
    RegExp idRegExp = RegExp(pattern.toString());
    return idRegExp.hasMatch(this);
  }

  bool get isValidPassport {
    Pattern pattern = r'^[0-9]{10,20}$';
    RegExp idRegExp = RegExp(pattern.toString());
    return idRegExp.hasMatch(this);
  }
}
