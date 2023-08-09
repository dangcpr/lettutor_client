import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import 'package:lettutor_client/controllers/account/accounts.dart';
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
                        setState(() { isDone = false; });
                        //int result = await AccountController.login(_emailController.text, _passwordController.text);
                        setState(() { isDone = true; });
                        debugPrint('Login');
                      }
                    },
                    child: isDone ? Text(AppLocalizations.of(context)!.loginTitle) : CircularProgressIndicator(color: Colors.white),
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