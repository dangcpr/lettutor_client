import 'package:animated_check/animated_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_client/logic/bloc/account/resend_email_verified/resend_email_bloc.dart';
import 'package:lettutor_client/logic/bloc/account/resend_email_verified/resend_email_event.dart';
import 'package:lettutor_client/logic/bloc/account/resend_email_verified/resend_email_state.dart';
import 'package:lettutor_client/views/auth/helpers/error_message.dart';
import 'package:lettutor_client/views/auth/helpers/success_message.dart';
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
              padding: EdgeInsets.symmetric(vertical: 15.0), 
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
                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 80.0),
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2.0,
                  ),
                ),
                child: AnimatedCheck(
                  progress: animation,
                  size: 80,
                  color: Theme.of(context).primaryColor,
                  strokeWidth: 10.0,
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: TextButton(
                child: Text(AppLocalizations.of(context)!.backToLogin),
                onPressed: () => {
                  Future.delayed(Duration.zero, () async {
                    Navigator.pushReplacementNamed(context, '/login');
                  })
                  //Navigator.pushNamed(context, '/login')
                }
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: TextButton(
                style: ButtonStyle(
                  //no color background
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                  foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
                  side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(
                      color: Theme.of(context).primaryColor, 
                      width: 1
                    )
                  ),
                ),
                child: BlocBuilder<ResendEmailBloc, ResendEmailState>(
                  builder: (context, state) {
                    if(state is ResendEmailInitial) {
                      return Text(AppLocalizations.of(context)!.resendEmail);
                    } 
                    else if (state is ResendEmailLoading) {
                      return CircularProgressIndicator(color: Theme.of(context).primaryColor);
                    } 
                    else if (state is ResendEmailSuccess) {
                      successMessage(AppLocalizations.of(context)!.pleaseCheckEmail(user), context);
                      return Text(AppLocalizations.of(context)!.resendEmail);                   
                    } else if (state is ResendEmailError) {
                      if(state.message == 'Email not found') {
                        errorMessage(AppLocalizations.of(context)!.emailNotFound, context);
                      } 
                      else if (state.message == 'Email was verified') {
                        errorMessage(AppLocalizations.of(context)!.emailWasVerified, context);
                      } 
                      else if (state.message == 'Connection Timeout') {
                        errorMessage(AppLocalizations.of(context)!.timeoutError, context);
                      }
                      else if (state.message == 'Internet Error') {
                        errorMessage(AppLocalizations.of(context)!.internetError, context);
                      }
                      else {
                        errorMessage(AppLocalizations.of(context)!.serverError, context);
                      }
                      return Text(AppLocalizations.of(context)!.resendEmail);
                    }
                    else {
                      return Text(AppLocalizations.of(context)!.resendEmail);
                    }
                  }
                ),
                onPressed: () => {
                  BlocProvider.of<ResendEmailBloc>(context).add(
                    ResendEmailPressed(email: user)
                  )
                }
              )
            ),
          ]
        ),
      )
    );
  }
}