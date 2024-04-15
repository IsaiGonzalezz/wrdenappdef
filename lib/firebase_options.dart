import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyC57jTQgZ_2smqcTPwgRRA5E66cbu5uEag',
    appId: '1:325179964642:web:67c6d0c3e08206f7b3f2bb',
    messagingSenderId: '325179964642',
    projectId: 'warden-7a639',
    authDomain: 'warden-7a639.firebaseapp.com',
    storageBucket: 'warden-7a639.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCl7ZK1GbFjZ6TGioPhEjU3MCpy3tTpxDI',
    appId: '1:325179964642:android:75149928fe663e17b3f2bb',
    messagingSenderId: '325179964642',
    projectId: 'warden-7a639',
    storageBucket: 'warden-7a639.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA7a-LQue-qvWrDNkqNOc2funq05-kPhaY',
    appId: '1:325179964642:ios:fa8379cc3b4124e6b3f2bb',
    messagingSenderId: '325179964642',
    projectId: 'warden-7a639',
    storageBucket: 'warden-7a639.appspot.com',
    iosClientId: '325179964642-tqbd7obqckjec8aj4bohs855gktj3c0n.apps.googleusercontent.com',
    iosBundleId: 'com.example.wardenTechsecure',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA7a-LQue-qvWrDNkqNOc2funq05-kPhaY',
    appId: '1:325179964642:ios:fa8379cc3b4124e6b3f2bb',
    messagingSenderId: '325179964642',
    projectId: 'warden-7a639',
    storageBucket: 'warden-7a639.appspot.com',
    iosClientId: '325179964642-tqbd7obqckjec8aj4bohs855gktj3c0n.apps.googleusercontent.com',
    iosBundleId: 'com.example.wardenTechsecure',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC57jTQgZ_2smqcTPwgRRA5E66cbu5uEag',
    appId: '1:325179964642:web:68797803dffbbe9eb3f2bb',
    messagingSenderId: '325179964642',
    projectId: 'warden-7a639',
    authDomain: 'warden-7a639.firebaseapp.com',
    storageBucket: 'warden-7a639.appspot.com',
  );
}
