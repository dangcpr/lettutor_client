import 'package:animated_check/animated_check.dart';
import 'package:flutter/material.dart';
import 'package:lettutor_client/views/settings/button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SendEmailVerifiedScreen extends StatefulWidget {
  const SendEmailVerifiedScreen({super.key});

  @override
  State<SendEmailVerifiedScreen> createState() => _SendEmailVerifiedScreenState();
}

class _SendEmailVerifiedScreenState extends State<SendEmailVerifiedScreen> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
      
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOutCirc
    ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    String user = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      //hide back button
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          const ButtonSettingSystem(),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0), 
              child: Align(alignment: Alignment.center, child: Text(AppLocalizations.of(context)!.success, style: Theme.of(context).textTheme.headlineLarge))
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0), 
              child: Align(alignment: Alignment.center, child: Text(AppLocalizations.of(context)!.createAccountSuccess, style: Theme.of(context).textTheme.headlineSmall)),
            ),
            SizedBox(
              height: 120,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0), 
                child: Align(alignment: Alignment.center, child: Text(AppLocalizations.of(context)!.pleaseCheckEmail(user), style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center)),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(), 
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2.0,
                  ),
                ),
                child: AnimatedCheck(
                  progress: animation,
                  size: 90,
                  color: Theme.of(context).primaryColor,
                  strokeWidth: 10.0,
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: TextButton(
                child: Text(AppLocalizations.of(context)!.backToLogin),
                onPressed: () => {
                  Navigator.pushNamedAndRemoveUntil(context, '/login', ModalRoute.withName('/login'))
                }
              )
            ),
          ]
        ),
      )
    );
  }
}