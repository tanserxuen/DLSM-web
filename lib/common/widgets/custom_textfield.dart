import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:styled_widget/styled_widget.dart';



class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? title;
  final double? titleSize;
  final FontWeight? titleFontWeight;
  final String? hintText;
  final int maxLines;
  final bool isNumberOnly;
  final int? maxNumberLength;
  final Widget? suffixWidget;
  final bool? obscureText;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.obscureText = true,
    this.suffixWidget,
    this.hintText,
    this.maxLines = 1,
    this.isNumberOnly = false,
    this.maxNumberLength,
    this.title,
    this.titleSize,
    this.titleFontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      title == null
          ? Container()
          : <Widget>[textFieldTitle()]
              .toRow(mainAxisAlignment: MainAxisAlignment.start),
      textField(),
    ].toColumn();
  }

  Text textFieldTitle() {
    return Text(
      title!,
      style: TextStyle(
        fontSize: titleSize ?? 16,
        fontWeight: titleFontWeight ?? FontWeight.w500,
      ),
    );
  }

  TextFormField textField() {
    bool obscureText = false;
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      keyboardType:
          isNumberOnly == true ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixWidget,
      ),
      validator: (val) {
        if (val == null || val.isEmpty || val.length < maxNumberLength!) {
          return 'Enter your $hintText';
        }
        return null;
      },
      maxLines: maxLines,
      inputFormatters: [
        isNumberOnly == true
            ? FilteringTextInputFormatter.digitsOnly
            : FilteringTextInputFormatter.singleLineFormatter,
      ],
    );
  }
}
