import 'package:flutter/material.dart';

void showUndoSnackBar(
    BuildContext context, String message, void Function()? onUndo) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'UNDO',
        onPressed: onUndo ?? () {},
      ),
    ),
  );
}
