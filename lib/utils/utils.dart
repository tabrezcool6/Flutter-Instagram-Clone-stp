import 'package:flutter/material.dart';

class Utils {
  ///
  /// SnackBar
  static showSnackBar(BuildContext context, String content) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }
}
