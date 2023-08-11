import 'package:flutter/material.dart';

class RegisterInfomationScreen extends StatefulWidget {
  const RegisterInfomationScreen({super.key});

  @override
  State<RegisterInfomationScreen> createState() => _RegisterInfomationScreenState();
}

class _RegisterInfomationScreenState extends State<RegisterInfomationScreen> {
  //Parameter
  
  @override
  Widget build(BuildContext context) {    
    String user = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: SafeArea(child: Text('Register Infomation: $user')),
    );
  }
}