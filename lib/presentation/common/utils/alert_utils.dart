import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class AlertUtils {
  static void showAlert(BuildContext context, String title, String message, {bool androidSnakeBar = true, void Function()? onPressed}) {
    if (androidSnakeBar && Platform.isAndroid) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(message)),
        );
    } else {
      showDialog<void>(
          context: context,
          builder: (_) => PlatformAlertDialog(
                title: Text(title),
                content: Text(message),
                actions: [
                  PlatformDialogAction(
                    child: const Text('Ok'),
                    onPressed: onPressed ?? () => Navigator.of(context).pop(),
                  )
                ],
              ));
    }
  }

  static void showError(BuildContext context, String message, {bool androidSnakeBar = true}) {
    showAlert(context, 'Error', message, androidSnakeBar: androidSnakeBar);
  }
}
