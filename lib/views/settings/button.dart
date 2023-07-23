import 'package:flutter/material.dart';
import 'package:lettutor_client/views/settings/index.dart';

class ButtonSettingSystem extends StatefulWidget {
  const ButtonSettingSystem({super.key});

  @override
  State<ButtonSettingSystem> createState() => _ButtonSettingSystemState();
}

class _ButtonSettingSystemState extends State<ButtonSettingSystem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Ink(
        width: 40.0,
        height: 40.0,
        decoration: ShapeDecoration(
          shape: CircleBorder(
            side: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
          ),
        ),
        child: IconButton(
          iconSize: 20.0,
          icon: Icon(Icons.settings, color: Theme.of(context).primaryColor),
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context)=> SystemSettingBottom(context),
            );
          }
        ),
      )
    );
  }
}