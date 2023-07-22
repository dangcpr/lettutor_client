import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lettutor_client/l10n/ln10.dart';
import 'package:lettutor_client/providers/systemProvider.dart';
import 'package:lettutor_client/themes/darkTheme.dart';
import 'package:lettutor_client/themes/lightTheme.dart';
import 'package:lettutor_client/views/auth/login/index.dart';
//import 'package:lettutor_client/views/auth/login/temp.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor_client/views/auth/signup/index.dart';
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
    //final systemProvider = Provider.of<SystemProvider>(context);

    return MaterialApp(
      title: 'LetTutor',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,      
      ],
      initialRoute: '/login',
      routes: {
        //'/': (context) => const LoginScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen()
        //'/temp': (context) => const TempScreen(),
      },
      home: const LoginScreen(),
    );
  }
}
