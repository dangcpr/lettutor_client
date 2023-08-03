import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lettutor_client/l10n/ln10.dart';
import 'package:lettutor_client/providers/systemProvider.dart';
import 'package:lettutor_client/themes/darkTheme.dart';
import 'package:lettutor_client/themes/lightTheme.dart';
import 'package:lettutor_client/views/auth/forgotPass/index.dart';
import 'package:lettutor_client/views/auth/login/index.dart';
//import 'package:lettutor_client/views/auth/login/temp.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor_client/views/auth/sendEmail/index.dart';
import 'package:lettutor_client/views/auth/signup/registerAccount/index.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => SystemProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    final systemProvider = Provider.of<SystemProvider>(context);
    systemProvider.loadOption();
    return MaterialApp(
      title: 'LetTutor',
      debugShowCheckedModeBanner: false,
      theme: (systemProvider.isDarkMode == 0 || systemProvider.isDarkMode == 2) ? lightTheme : darkTheme,
      darkTheme: (systemProvider.isDarkMode == 1 || systemProvider.isDarkMode == 2) ? darkTheme : lightTheme,
      supportedLocales: L10n.all,
      locale: systemProvider.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,      
      ],
      initialRoute: '/',
      routes: {
        //'/': (context) => const LoginScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/forgotPass': (context) => const ForgetPassScreen(),
        '/sendEmailVerified': (context) => const SendEmailVerifiedScreen(),
        //'/temp': (context) => const TempScreen(),
      },
      home: const LoginScreen(),
    );
  }
}

