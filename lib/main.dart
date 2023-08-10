import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lettutor_client/logic/bloc/account/login/login_bloc.dart';
import 'package:lettutor_client/logic/cubit/system/dark_mode_cubit.dart';
import 'package:lettutor_client/logic/cubit/system/language_cubit.dart';
import 'package:lettutor_client/l10n/ln10.dart';
import 'package:lettutor_client/themes/darkTheme.dart';
import 'package:lettutor_client/themes/lightTheme.dart';
import 'package:lettutor_client/views/auth/forgotPass/index.dart';
import 'package:lettutor_client/views/auth/login/index.dart';
//import 'package:lettutor_client/views/auth/login/temp.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor_client/views/auth/sendEmail/index.dart';
import 'package:lettutor_client/views/auth/signup/registerAccount/index.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<DarkModeCubit>(create: (_) => DarkModeCubit()),
    BlocProvider<LanguageCubit>(create: (_) => LanguageCubit()),
    BlocProvider<LoginBloc>(create: (_) => LoginBloc()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    context.read<DarkModeCubit>().loadOption();
    context.read<LanguageCubit>().loadOption();

    final isDarkMode = context.watch<DarkModeCubit>().state;
    final locale = context.watch<LanguageCubit>().state;

    return MaterialApp(
      title: 'LetTutor',
      debugShowCheckedModeBanner: false,
      theme: (isDarkMode == 0 || isDarkMode == 2) ? lightTheme : darkTheme,
      darkTheme: (isDarkMode == 1 || isDarkMode == 2) ? darkTheme : lightTheme,
      supportedLocales: L10n.all,
      locale: locale,
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

