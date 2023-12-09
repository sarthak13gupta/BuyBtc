import 'package:flutter/material.dart';

Future<void> showErrorDialog({
  required BuildContext context,
  required List<String> message,
}) async {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message[0]),
          content: Text(message[1]),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"))
          ],
        );
      });
}
