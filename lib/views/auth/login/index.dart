import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Image.asset('assets/images/lettutor.png', scale: 1.25),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding (
                      padding: const EdgeInsets.only(top: 80.0),
                      child: Text(
                        AppLocalizations.of(context)!.welcomeBackTitle, 
                        style: Theme.of(context).textTheme.headlineMedium,
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: AppLocalizations.of(context)!.emailLabel,
                        hintText: AppLocalizations.of(context)!.emailHelper,
                      ),
                      validator: (value) {
                        if(value!.isEmpty)  {
                          return AppLocalizations.of(context)!.emailErrorEmpty;
                        }
                        if(EmailValidator.validate(value) == false) {
                          return AppLocalizations.of(context)!.emailErrorFormat;
                        }
                        else {
                          return null;
                        }
                      },
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),           
                    child: TextFormField(
                      obscureText: _passwordVisible,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: !_passwordVisible ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        prefixIcon: Icon(Icons.password),
                        labelText: AppLocalizations.of(context)!.passwordLabel,
                        hintText: AppLocalizations.of(context)!.passwordHelper,
                      ),
                      validator: (value) {
                        if(value!.isEmpty)  {
                          return AppLocalizations.of(context)!.passwordErrorEmpty;
                        }
                        else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: TextButton(
                      onPressed: () => {
                        if(_formKey.currentState!.validate()) {
                          debugPrint('Login')
                        }
                      },
                      child: Text(AppLocalizations.of(context)!.loginTitle),
                    )
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding (
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        AppLocalizations.of(context)!.otherMethodLogin, 
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(MdiIcons.facebook),
                          onPressed: () => debugPrint('Facebook'),
                        ),
                        IconButton(
                          icon: Icon(MdiIcons.google),
                          onPressed: () => debugPrint('Facebook'),
                        ),
                      ],
                    )
                  ),
                  Align(
                    child: Padding (
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppLocalizations.of(context)!.notHaveAccount + ' '),
                          RichText(
                            text: TextSpan (
                              text: AppLocalizations.of(context)!.registerNow,
                              style: Theme.of(context).textTheme.labelMedium,
                              recognizer: TapGestureRecognizer()..onTap = () => Navigator.pushNamed(context, '/signup')                      
                            )
                          ),
                        ] 
                      )
                    ),
                  ),                            
                ],
              )
            )
          )
        )
      ),
    );
  }
}