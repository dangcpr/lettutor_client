// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA5Yj3gjDxn81DxDaFkNQSbuIISPq_3lzU',
    appId: '1:992762248741:web:90bc4d2e1c27071f7c89cc',
    messagingSenderId: '992762248741',
    projectId: 'lettutor-d3e18',
    authDomain: 'lettutor-d3e18.firebaseapp.com',
    storageBucket: 'lettutor-d3e18.appspot.com',
    measurementId: 'G-Y1FDHB22TB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA8xjkJWhDFpEVpWO5LrQAb6Kiu6TlqFRk',
    appId: '1:992762248741:android:f8d1f7172145de667c89cc',
    messagingSenderId: '992762248741',
    projectId: 'lettutor-d3e18',
    storageBucket: 'lettutor-d3e18.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB4vAwCEmaL4_dM3rU60kZNoBze9UPr8gs',
    appId: '1:992762248741:ios:ad767aa8864f54667c89cc',
    messagingSenderId: '992762248741',
    projectId: 'lettutor-d3e18',
    storageBucket: 'lettutor-d3e18.appspot.com',
    iosClientId: '992762248741-3l39idpn6pufobqvfu7p4m6ev566ulgf.apps.googleusercontent.com',
    iosBundleId: 'com.example.lettutorClient',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB4vAwCEmaL4_dM3rU60kZNoBze9UPr8gs',
    appId: '1:992762248741:ios:79e5aedad3471f847c89cc',
    messagingSenderId: '992762248741',
    projectId: 'lettutor-d3e18',
    storageBucket: 'lettutor-d3e18.appspot.com',
    iosClientId: '992762248741-qr1t6dm97q02qpp0e9eu9tovsg8qaece.apps.googleusercontent.com',
    iosBundleId: 'com.example.lettutorClient.RunnerTests',
  );
}
