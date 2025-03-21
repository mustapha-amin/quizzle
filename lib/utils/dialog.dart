import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void showCustomDialog(
    {required BuildContext context,
    required String title,
    required String message}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Ok"),
          )
        ],
      );
    },
  );
}
