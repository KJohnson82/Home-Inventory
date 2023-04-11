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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyB_HFq0jpJrU1eCSyUhdX8fon0AEeXGDtY',
    appId: '1:502102498640:web:0cb6adc0b9a749c451a055',
    messagingSenderId: '502102498640',
    projectId: 'homeventory-5f016',
    authDomain: 'homeventory-5f016.firebaseapp.com',
    storageBucket: 'homeventory-5f016.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDMbvi21nJV38Y-ceRA1pTtNPHDd00JQiw',
    appId: '1:502102498640:android:3086b74d8e1dbaa051a055',
    messagingSenderId: '502102498640',
    projectId: 'homeventory-5f016',
    storageBucket: 'homeventory-5f016.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC-b3qvSnXXs6-cWXndSdP7UwmKOFCQYE8',
    appId: '1:502102498640:ios:292043be611d559951a055',
    messagingSenderId: '502102498640',
    projectId: 'homeventory-5f016',
    storageBucket: 'homeventory-5f016.appspot.com',
    androidClientId: '502102498640-gm66t6bq5h5k6mle2ndlqjfdvtlghbac.apps.googleusercontent.com',
    iosClientId: '502102498640-6s9njjg3cbpme697fi5qo005k5sfmkfn.apps.googleusercontent.com',
    iosBundleId: 'com.example.hvtest1',
  );
}