import 'package:flutter/material.dart';
import 'package:lettutor_client/providers/systemProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TempScreen extends StatefulWidget {
  const TempScreen({super.key});

  @override
  State<TempScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  int _counter = 0;
  bool _isDarkMode = false;
  String selectedItems = '';

  @override
  void initState() {
    super.initState();
    _isDarkMode = context.read<SystemProvider>().isDarkMode;
    selectedItems = context.read<SystemProvider>().locale.languageCode;
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem> items = [
      DropdownMenuItem(value: 'en', child: Text(AppLocalizations.of(context)!.languageE)),
      DropdownMenuItem(value: 'vi', child: Text(AppLocalizations.of(context)!.languageV)),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('LetTutor'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text(AppLocalizations.of(context)!.titleDarkMode + "  ", style: Theme.of(context).textTheme.bodyMedium),
              Switch(
                value: _isDarkMode,
                onChanged: (val) => {
                  context.read<SystemProvider>().changeOption(),
                  _isDarkMode = val
                }
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: <Widget>[
                Text(AppLocalizations.of(context)!.titleChoose + "  ", style: Theme.of(context).textTheme.bodyMedium),
                DropdownButton(
                  value: selectedItems,
                  items: items, 
                  onChanged: (value) => {
                    context.read<SystemProvider>().changeLocale(Locale(value.toString())),
                    selectedItems = value,
                  }
                ),
            ]),
            Text(
              AppLocalizations.of(context)!.notiPlus,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
