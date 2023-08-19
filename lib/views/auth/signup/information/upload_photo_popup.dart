import 'package:flutter/material.dart';
import 'package:lettutor_client/logic/cubit/register_info/upload_image.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChooseOptionImage extends StatefulWidget {
  const ChooseOptionImage(BuildContext context, {super.key});

  @override
  State<ChooseOptionImage> createState() => _ChooseOptionImageState();
}

class _ChooseOptionImageState extends State<ChooseOptionImage> {
  @override
  void initState() {
    super.initState();
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
                TextButton(
                  onPressed: () {
                    context.read<UploadImageCubit>().uploadImage(context);
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.upload_file, size: 30),
                      Text('  ' + AppLocalizations.of(context)!.uploadPhoto)
                    ],
                  )
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 5), child: Text(AppLocalizations.of(context)!.or, style: Theme.of(context).textTheme.bodyLarge)),
                TextButton(
                  onPressed: () {
                    context.read<UploadImageCubit>().takePhoto(context);
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera, size: 30),
                      Text('  ' + AppLocalizations.of(context)!.usingCamera)
                    ],
                  )
                ),
              ],
            )
          ),
        ),
      )
    );
  }
}