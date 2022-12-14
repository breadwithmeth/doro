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
    apiKey: 'AIzaSyDHy_BVqSSD8XQXQ3AMxnqXrditB5rwlt0',
    appId: '1:821539749808:web:02b83d83d3dcdf3f3a6075',
    messagingSenderId: '821539749808',
    projectId: 'doro-37821',
    authDomain: 'doro-37821.firebaseapp.com',
    storageBucket: 'doro-37821.appspot.com',
    measurementId: 'G-R931Q4B4MP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBLIZFSY4qdgKSVeiZHEFmzgEnaiFyYzVQ',
    appId: '1:821539749808:android:569af342ed9a05323a6075',
    messagingSenderId: '821539749808',
    projectId: 'doro-37821',
    storageBucket: 'doro-37821.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCDRCpbhCZmYphp5H_kucuwpVqd5WtVEjc',
    appId: '1:821539749808:ios:df3c230bbcee23f03a6075',
    messagingSenderId: '821539749808',
    projectId: 'doro-37821',
    storageBucket: 'doro-37821.appspot.com',
    iosClientId: '821539749808-j0nfav4lpo9a4qoa28rddk9acm4tceft.apps.googleusercontent.com',
    iosBundleId: 'com.example.doro',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCDRCpbhCZmYphp5H_kucuwpVqd5WtVEjc',
    appId: '1:821539749808:ios:df3c230bbcee23f03a6075',
    messagingSenderId: '821539749808',
    projectId: 'doro-37821',
    storageBucket: 'doro-37821.appspot.com',
    iosClientId: '821539749808-j0nfav4lpo9a4qoa28rddk9acm4tceft.apps.googleusercontent.com',
    iosBundleId: 'com.example.doro',
  );
}
