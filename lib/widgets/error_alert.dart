import 'package:flutter/material.dart';

class ErrorAlert extends StatelessWidget {
  final String errorMessage;

  ErrorAlert({required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Thông báo'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(errorMessage),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop(); // Đóng cảnh báo
          },
        ),
      ],
    );
  }
}