// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyAyySS4qUvBiSadoplbTQT6g-vi3OElxWM',
    appId: '1:588077245698:web:0122f07e52f59e65a70e1b',
    messagingSenderId: '588077245698',
    projectId: 'bahati-4911e',
    authDomain: 'bahati-4911e.firebaseapp.com',
    storageBucket: 'bahati-4911e.firebasestorage.app',
    measurementId: 'G-ER707HTEVD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDeNQTfKf7OcWYVru5BkIqZ1QUbfAZBaZc',
    appId: '1:588077245698:android:a6c8452cf0eb49a4a70e1b',
    messagingSenderId: '588077245698',
    projectId: 'bahati-4911e',
    storageBucket: 'bahati-4911e.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA811jYvOmqeOTEdOJSouCUDnOiP0HGiIw',
    appId: '1:588077245698:ios:2a8a3ac852e0b4e4a70e1b',
    messagingSenderId: '588077245698',
    projectId: 'bahati-4911e',
    storageBucket: 'bahati-4911e.firebasestorage.app',
    iosBundleId: 'com.example.fuelCheck',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA811jYvOmqeOTEdOJSouCUDnOiP0HGiIw',
    appId: '1:588077245698:ios:2a8a3ac852e0b4e4a70e1b',
    messagingSenderId: '588077245698',
    projectId: 'bahati-4911e',
    storageBucket: 'bahati-4911e.firebasestorage.app',
    iosBundleId: 'com.example.fuelCheck',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAyySS4qUvBiSadoplbTQT6g-vi3OElxWM',
    appId: '1:588077245698:web:b87ce008516df2c2a70e1b',
    messagingSenderId: '588077245698',
    projectId: 'bahati-4911e',
    authDomain: 'bahati-4911e.firebaseapp.com',
    storageBucket: 'bahati-4911e.firebasestorage.app',
    measurementId: 'G-LRWRGXDZY8',
  );
}
