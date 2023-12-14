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
    apiKey: 'AIzaSyAg8LEdYws1hKxPXMl61MFBYeEUnAeP-7E',
    appId: '1:52022421846:web:60567a30f23ab7fb03cef7',
    messagingSenderId: '52022421846',
    projectId: 'diry-cbeda',
    authDomain: 'diry-cbeda.firebaseapp.com',
    storageBucket: 'diry-cbeda.appspot.com',
    measurementId: 'G-YMQN42K028',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDY4dYwyR9IRCs_2I7_17cVVfwUwCTbF-Q',
    appId: '1:52022421846:android:bd725dbfc98964f303cef7',
    messagingSenderId: '52022421846',
    projectId: 'diry-cbeda',
    storageBucket: 'diry-cbeda.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB8D7-qFfsR3qsYE4lxFfdh1QzqQIh-25A',
    appId: '1:52022421846:ios:a02fe47bc2f371e103cef7',
    messagingSenderId: '52022421846',
    projectId: 'diry-cbeda',
    storageBucket: 'diry-cbeda.appspot.com',
    iosBundleId: 'com.example.dairyheart',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB8D7-qFfsR3qsYE4lxFfdh1QzqQIh-25A',
    appId: '1:52022421846:ios:6ebd2171282e6c7003cef7',
    messagingSenderId: '52022421846',
    projectId: 'diry-cbeda',
    storageBucket: 'diry-cbeda.appspot.com',
    iosBundleId: 'com.example.dairyheart.RunnerTests',
  );
}
