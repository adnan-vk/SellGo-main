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
    apiKey: 'AIzaSyCdkYFzGY_NbFV_BuvSyu3N2s91br5yy0A',
    appId: '1:647544119714:web:145ccd548593e55e8092fb',
    messagingSenderId: '647544119714',
    projectId: 'sellgo2-beea7',
    authDomain: 'sellgo2-beea7.firebaseapp.com',
    storageBucket: 'sellgo2-beea7.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAWQn4u4A0Q-z6T8LH9cDqlNiMNpuuo3Jk',
    appId: '1:647544119714:android:541956768bb8fb958092fb',
    messagingSenderId: '647544119714',
    projectId: 'sellgo2-beea7',
    storageBucket: 'sellgo2-beea7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCGoivul_sqpSmCjr7Y3MiYTI8IY-aNFvI',
    appId: '1:647544119714:ios:eb72274d7fbb4c588092fb',
    messagingSenderId: '647544119714',
    projectId: 'sellgo2-beea7',
    storageBucket: 'sellgo2-beea7.appspot.com',
    iosClientId: '647544119714-6ih139oofi5gjsh3164ike4qk648eu2e.apps.googleusercontent.com',
    iosBundleId: 'com.example.sellgo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCGoivul_sqpSmCjr7Y3MiYTI8IY-aNFvI',
    appId: '1:647544119714:ios:15f265d8b3d02cb88092fb',
    messagingSenderId: '647544119714',
    projectId: 'sellgo2-beea7',
    storageBucket: 'sellgo2-beea7.appspot.com',
    iosClientId: '647544119714-meei61dij9tjgadc3fvib33ap0k389n2.apps.googleusercontent.com',
    iosBundleId: 'com.example.sellgo.RunnerTests',
  );
}
