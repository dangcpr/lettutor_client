import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lettutor_client/controllers/account/accounts.dart';
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
  bool _isDone = true;
  int _result = 1;
  int result = 1;
  var Account = {
    'email': TextEditingController(),
    'password': TextEditingController(),
    'rePassword': TextEditingController(),
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

                            if(_result == 0) {
                              _result = 1;
                              return AppLocalizations.of(context)!.emailExists;
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
                          controller: Account['rePassword'],
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
                  onPressed: () async {
                    if(_formKey.currentState!.validate() == false) {
                        return;
                    }

                    setState(() => _isDone = false);
                    result = await AccountController.signup(Account['email']!.text, Account['password']!.text, Account['rePassword']!.text);
                    setState(() { _isDone = true; });
                    setState(() { _result = result; });

                    if(result == 1) {
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamedAndRemoveUntil(context, '/sendEmailVerified', ModalRoute.withName('/sendEmailVerified'), arguments: Account['email']!.text);
                    }
                    else if(result == 0) {
                      _formKey.currentState!.validate();
                    }
                    else if (result == 2) {
                      debugPrint(result.toString());
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          // ignore: use_build_context_synchronously
                          content: Text(AppLocalizations.of(context)!.formatInfoError),
                          backgroundColor: Colors.red,
                        )
                      );
                    }
                    else if(result == 3) {
                      debugPrint(result.toString());
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          // ignore: use_build_context_synchronously
                          content: Text(AppLocalizations.of(context)!.timeoutError, style: TextStyle(color: Colors.white),),
                          backgroundColor: Colors.red,
                        )
                      );
                    }
                    else if(result == 4) {
                      debugPrint(result.toString());
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          // ignore: use_build_context_synchronously
                          content: Text(AppLocalizations.of(context)!.internetError, style: TextStyle(color: Colors.white),),
                          backgroundColor: Colors.red,
                        )
                      );
                    }
                    else {
                      debugPrint(result.toString());
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          // ignore: use_build_context_synchronously
                          content: Text(AppLocalizations.of(context)!.serverError, style: TextStyle(color: Colors.white),),
                          backgroundColor: Colors.red,
                        )
                      );
                    }
                  },
                  child: _isDone ? Text(AppLocalizations.of(context)!.signupButton) : const CircularProgressIndicator(color: Colors.white),
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