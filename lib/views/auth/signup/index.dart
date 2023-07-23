import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lettutor_client/views/settings/button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;
  bool _rePasswordVisible = true;
  var Account = {
    'email': TextEditingController(),
    'password': TextEditingController(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          actions: [
            const ButtonSettingSystem(),
          ],
        )
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0), 
                child: Align(alignment: Alignment.center, child: Text(AppLocalizations.of(context)!.newAccount, style: Theme.of(context).textTheme.headlineLarge))
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0), 
                child: Align(alignment: Alignment.center, child: Text(AppLocalizations.of(context)!.newAccountSub, style: Theme.of(context).textTheme.headlineSmall)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                child: SizedBox(
                  height: 380,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80,
                        child: TextFormField(
                          controller: Account['email'],
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
                      SizedBox(
                        height: 80,        
                        child: TextFormField(
                          controller: Account['password'],
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
                            if(value.length < 8) {
                              return AppLocalizations.of(context)!.passwordErrorLength;
                            }
                            else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 80,        
                        child: TextFormField(
                          obscureText: _rePasswordVisible,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: !_rePasswordVisible ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _rePasswordVisible = !_rePasswordVisible;
                                });
                              },
                            ),
                            prefixIcon: Icon(Icons.password),
                            labelText: AppLocalizations.of(context)!.rePasswordLabel,
                            hintText: AppLocalizations.of(context)!.rePasswordHelper,
                          ),
                          validator: (value) {
                            if(value!.isEmpty)  {
                              return AppLocalizations.of(context)!.rePassWordErrorEmpty;
                            }
                            if(value != Account['password']!.text) {
                              return AppLocalizations.of(context)!.rePassWordErrorNotMatch;
                            }
                            else {
                              return null;
                            }

                          },
                        ),
                      ),
                    ]
                  )
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextButton(
                  onPressed: () => {
                    if(_formKey.currentState!.validate()) {
                      debugPrint('Login')
                    }
                  },
                  child: Text(AppLocalizations.of(context)!.signupButton),
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.alreadyHaveAccount + ' '),
                    RichText(
                      text: TextSpan (
                        text: AppLocalizations.of(context)!.loginNow,
                        style: Theme.of(context).textTheme.labelMedium,
                        recognizer: TapGestureRecognizer()..onTap = () => Navigator.pop(context),
                      )
                    ),
                  ],
                )
              ),
            ]
          )
        )
      ),
    );
  }
}