import 'package:flutter/material.dart';
import 'package:lettutor_client/cubit/system/dark_mode_cubit.dart';
import 'package:lettutor_client/cubit/system/language_cubit.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SystemSettingBottom extends StatefulWidget {
  const SystemSettingBottom(BuildContext context, {super.key});

  @override
  State<SystemSettingBottom> createState() => _SystemSettingBottomState();
}

class _SystemSettingBottomState extends State<SystemSettingBottom> {
  int darkModeSetting = 0;
  Locale locale = const Locale('vi');
  @override
  void initState() {
    super.initState();
    darkModeSetting = context.read<DarkModeCubit>().state;
    locale = context.read<LanguageCubit>().state;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: 200,
        child: Center(
          child: Padding (
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.titleDarkMode, style: Theme.of(context).textTheme.bodyMedium),
                    DropdownButton(
                      value: darkModeSetting,
                      items: [
                        DropdownMenuItem(value: 1, child: Text(AppLocalizations.of(context)!.on)),
                        DropdownMenuItem(value: 0, child: Text(AppLocalizations.of(context)!.off)),
                        DropdownMenuItem(value: 2, child: Text(AppLocalizations.of(context)!.system)),
                      ],
                      onChanged: (val) {
                        context.read<DarkModeCubit>().changeTheme(val as int);
                        setState(() {
                          darkModeSetting = val as int;
                        });
                      }
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.titleChoose, style: Theme.of(context).textTheme.bodyMedium),
                    DropdownButton(
                      value: locale.languageCode,
                      items: [
                        DropdownMenuItem(value: 'en', child: Text(AppLocalizations.of(context)!.languageE)),
                        DropdownMenuItem(value: 'vi', child: Text(AppLocalizations.of(context)!.languageV)),
                      ],
                      onChanged: (val) {
                        context.read<LanguageCubit>().changeLocale(Locale(val.toString()));
                        setState(() {
                          locale = Locale(val.toString());
                        });
                      }
                    )
                  ],
                )
              ],
            )
          ),
        ),
      )
    );
  }
}