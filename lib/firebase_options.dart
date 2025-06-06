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
    apiKey: 'AIzaSyCi63vY-d0-h9amKc_Z8u-GGll7aFKiTKw',
    appId: '1:678125344113:web:409eac61dfaba2d214d2d0',
    messagingSenderId: '678125344113',
    projectId: 'pothole-detector-fb59f',
    authDomain: 'pothole-detector-fb59f.firebaseapp.com',
    databaseURL: 'https://pothole-detector-fb59f-default-rtdb.firebaseio.com',
    storageBucket: 'pothole-detector-fb59f.firebasestorage.app',
    measurementId: 'G-HFXQ9MGLSR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBhhhGN5nF9thTE0tTD9MzuwUAb-4tpfNs',
    appId: '1:678125344113:android:8af550ee62c4a29014d2d0',
    messagingSenderId: '678125344113',
    projectId: 'pothole-detector-fb59f',
    databaseURL: 'https://pothole-detector-fb59f-default-rtdb.firebaseio.com',
    storageBucket: 'pothole-detector-fb59f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCwCx15VUwt4bY9cSOl_HMXCpyFYLRNwiI',
    appId: '1:678125344113:ios:95020a9a46198bf314d2d0',
    messagingSenderId: '678125344113',
    projectId: 'pothole-detector-fb59f',
    databaseURL: 'https://pothole-detector-fb59f-default-rtdb.firebaseio.com',
    storageBucket: 'pothole-detector-fb59f.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCwCx15VUwt4bY9cSOl_HMXCpyFYLRNwiI',
    appId: '1:678125344113:ios:95020a9a46198bf314d2d0',
    messagingSenderId: '678125344113',
    projectId: 'pothole-detector-fb59f',
    databaseURL: 'https://pothole-detector-fb59f-default-rtdb.firebaseio.com',
    storageBucket: 'pothole-detector-fb59f.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCi63vY-d0-h9amKc_Z8u-GGll7aFKiTKw',
    appId: '1:678125344113:web:1c92422b3d54f12c14d2d0',
    messagingSenderId: '678125344113',
    projectId: 'pothole-detector-fb59f',
    authDomain: 'pothole-detector-fb59f.firebaseapp.com',
    databaseURL: 'https://pothole-detector-fb59f-default-rtdb.firebaseio.com',
    storageBucket: 'pothole-detector-fb59f.firebasestorage.app',
    measurementId: 'G-W359D2HP34',
  );
}
