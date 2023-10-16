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
    apiKey: 'AIzaSyDOE5n0g1kNc59df_EYXk2zHQKiZUSMwKA',
    appId: '1:958055587600:web:aefde5feb672b1145a0f95',
    messagingSenderId: '958055587600',
    projectId: 'fluttynotes-project',
    authDomain: 'fluttynotes-project.firebaseapp.com',
    storageBucket: 'fluttynotes-project.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBk7FGhORpummUNgNG77QWoMG8fT0FzpjU',
    appId: '1:958055587600:android:4e55a30a8c0f1ad35a0f95',
    messagingSenderId: '958055587600',
    projectId: 'fluttynotes-project',
    storageBucket: 'fluttynotes-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAC-NnxlTvP9e7wDXL4xYT7ogWiZvBP3xM',
    appId: '1:958055587600:ios:c250051a6c0fd20e5a0f95',
    messagingSenderId: '958055587600',
    projectId: 'fluttynotes-project',
    storageBucket: 'fluttynotes-project.appspot.com',
    iosBundleId: 'com.threecloud.fluttynotes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAC-NnxlTvP9e7wDXL4xYT7ogWiZvBP3xM',
    appId: '1:958055587600:ios:990314d2b63edd565a0f95',
    messagingSenderId: '958055587600',
    projectId: 'fluttynotes-project',
    storageBucket: 'fluttynotes-project.appspot.com',
    iosBundleId: 'com.threecloud.fluttynotes.RunnerTests',
  );
}