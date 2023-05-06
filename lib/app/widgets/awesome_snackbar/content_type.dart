import 'package:flutter/cupertino.dart';

import 'default_color.dart';

/// to handle failure, success, help and warning `ContentType` class is being used
class SnackContentType {
  /// message is `required` parameter
  final String message;

  /// color is optional, if provided null then `DefaultColors` will be used
  final Color? color;

  const SnackContentType(this.message, [this.color]);

  static const SnackContentType help = SnackContentType('help', DefaultColors.helpBlue);
  static const SnackContentType failure =
  SnackContentType('failure', DefaultColors.failureRed);
  static const SnackContentType success =
  SnackContentType('success', DefaultColors.successGreen);
  static const SnackContentType warning =
  SnackContentType('warning', DefaultColors.warningYellow);
}