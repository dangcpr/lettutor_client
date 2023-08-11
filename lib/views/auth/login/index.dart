import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor_client/logic/bloc/account/login/login_bloc.dart';
import 'package:lettutor_client/logic/bloc/account/login/login_event.dart';
import 'package:lettutor_client/logic/bloc/account/login/login_state.dart';
import 'package:lettutor_client/views/auth/helpers/error_message.dart';
import 'package:lettutor_client/views/settings/button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = true;
  bool isDone = true;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LoginBloc>(context).add(LoginInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            const ButtonSettingSystem(),
          ],
        )
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0, top: 25.0),
                  child: Image.asset('assets/images/lettutor.png', scale: 1.25),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding (
                    padding: const EdgeInsets.only(top: 50.0, bottom: 7.0),
                    child: Text(
                      AppLocalizations.of(context)!.welcomeBackTitle, 
                      style: Theme.of(context).textTheme.headlineMedium,
                    )
                  ),
                ),
                SizedBox(
                  height: 80,
                  child: TextFormField(
                    controller: _emailController,
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
                    controller: _passwordController,
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
                Align(
                  child: Padding (
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.forgotPass + ' '),
                        RichText(
                          text: TextSpan (
                            text: AppLocalizations.of(context)!.retakePass,
                            style: Theme.of(context).textTheme.labelMedium,
                            recognizer: TapGestureRecognizer()..onTap = () => Navigator.pushNamed(context, '/forgotPass')                      
                          )
                        ),
                      ] 
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: TextButton(
                    onPressed: () async {
                      if(_formKey.currentState!.validate() == false) {
                        return;
                      }
                      else {
                        BlocProvider.of<LoginBloc>(context).add(
                          LoginButtonPressed(email: _emailController.text, password: _passwordController.text)
                        );
                      }
                    },
                    child: BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if(state is LoginInitial) {
                          return Text(AppLocalizations.of(context)!.loginTitle);
                        } 
                        else if (state is LoginLoading) {
                          return const CircularProgressIndicator(color: Colors.white);
                        } 
                        else if (state is LoginError) {
                          if(state.message == 'Wrong Email or Password') {
                            errorMessage(AppLocalizations.of(context)!.wrongLogin, context);
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
                          return Text(AppLocalizations.of(context)!.loginTitle);
                        } 
                        else if (state is LoginSuccess) {
                          if(state.account.verified == false) {
                            Future.delayed(Duration.zero, () async {
                              Navigator.pushReplacementNamed(context, '/sendEmailVerified', arguments: state.account.email);
                            });
                          } 
                          else {
                            if (state.account.last_login == DateTime(1)) {
                              debugPrint('555');
                              Future.delayed(Duration.zero, () async {
                                Navigator.pushReplacementNamed(context, '/registerInfo', arguments: state.account.email);
                              });
                            } 
                            else {
                              Future.delayed(Duration.zero, () async {
                                Navigator.pushReplacementNamed(context, '/student');
                              });
                            }
                          }
                          BlocProvider.of<LoginBloc>(context).add(LoginInitialEvent());
                          return Text(AppLocalizations.of(context)!.loginTitle);
                        } else {
                          return Text(AppLocalizations.of(context)!.loginTitle);
                        }
                      }
                    )
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
      ),
    );
  }
}