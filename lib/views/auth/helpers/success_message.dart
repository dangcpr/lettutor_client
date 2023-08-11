import 'package:flutter/material.dart';

void successMessage(String message, BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback((_) => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white),),
      backgroundColor: Colors.green,
    )
  ));
}