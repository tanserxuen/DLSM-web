
import 'package:flutter/material.dart';





class CustomElevatedButton extends ElevatedButton {
  CustomElevatedButton({
    Key? key,
    required VoidCallback onPressed,
    required String label,
    required ThemeData theme,
    double textSize = 16,
    bool autofocus = false,
    Color? color,
    IconData? icon,
    BorderSide? border,
    ButtonStyle? style,
    bool isDisabled = false,
  }) : super(
          key: key,
          onPressed: isDisabled ? null : onPressed,
          child: _buildChild(label, textSize, icon),
          autofocus: autofocus,
          style: style ??
              ButtonStyle(
                elevation: theme.elevatedButtonTheme.style?.elevation,
                overlayColor: MaterialStateProperty.all<Color>(
                    theme.primaryColor.withOpacity(0.2)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(theme.primaryColor),
                foregroundColor: MaterialStateProperty.all<Color>(
                  color ?? theme.textTheme.labelLarge?.color ?? Colors.white,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: border ?? BorderSide.none,
                  ),
                ),
              ),
        );

  static Widget _buildChild(String label, double textSize, IconData? icon) {
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: textSize + 4),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              style: TextStyle(fontSize: textSize),
            ),
          ),
        ],
      );
    } else {
      return Text(
        label,
        style: TextStyle(fontSize: textSize),
      );
    }
  }
}
