import 'package:flutter/material.dart';

class CustomBanner extends MaterialBanner {
  CustomBanner({
    Key? key,
    required String message,
    VoidCallback? onPressed,
  }) : super(
          key: key,
          content: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          leading: SizedBox(
            width: 24.0,
            height: 24.0,
            child: IconButton(
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              icon: Icon(
                Icons.close,
                color: Colors.white,
                size: 20.0,
              ),
              onPressed: onPressed,
            ),
          ),
          padding: EdgeInsets.all(16.0),
          elevation: 6.0,

          actions: [
            TextButton(
              onPressed: onPressed,
              child: Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ], // Add an empty list of actions
        );
}
