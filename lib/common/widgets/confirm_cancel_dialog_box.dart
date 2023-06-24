
import 'package:dlsm_web/app/index.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../widgets/custom_elevatedbutton.dart';




class ConfirmCancelDialogBox extends StatelessWidget {
  final String title;
  final String? description;
  final Widget? detailsWidget;

  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;


  const ConfirmCancelDialogBox({
    super.key,
    required this.title,
    this.description,
    this.detailsWidget,
    this.onCancel,
    this.onConfirm,
  });


  @override
  Widget build(BuildContext context) {
    
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(description!).padding(bottom: 20),
        detailsWidget ?? const SizedBox.shrink(),
      ],
    );


    final cancelButton = CustomElevatedButton(
      theme: CustomTheme.invisibleTheme,
      label: 'Cancel',
      onPressed: () {
        navigator.pop(false);
        if (onCancel != null) onCancel!();
      },
    );

    final confirmButton = CustomElevatedButton(
      theme: CustomTheme.activeTheme,
      label: 'Confirm',
      onPressed: () {
        navigator.pop(true);
        if (onConfirm != null) onConfirm!();
      },
    );

    return AlertDialog(
      title: Text(title),
      content: content,
      actions: [ cancelButton, confirmButton ],
    );
  }
}
