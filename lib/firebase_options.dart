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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyALFZQ5tTubbm4nW4TUwaBmAJ_W_cbh6WE',
    appId: '1:709874820337:web:0c3290bd8b1a39516e7550',
    messagingSenderId: '709874820337',
    projectId: 'quizzle-4e83d',
    authDomain: 'quizzle-4e83d.firebaseapp.com',
    storageBucket: 'quizzle-4e83d.appspot.com',
    measurementId: 'G-QC0H4STQLX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDYEUfcVhmssSLvo5NbW5152kCzOhLVK6o',
    appId: '1:709874820337:android:fcbd2885ac2ff88c6e7550',
    messagingSenderId: '709874820337',
    projectId: 'quizzle-4e83d',
    storageBucket: 'quizzle-4e83d.appspot.com',
  );
}
