import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDHtGXqhG1TangXhemQSeW6BjkjVHmLYIs",
            authDomain: "kyzdarskii-7oxn59.firebaseapp.com",
            projectId: "kyzdarskii-7oxn59",
            storageBucket: "kyzdarskii-7oxn59.appspot.com",
            messagingSenderId: "735930979850",
            appId: "1:735930979850:web:6c887343695aaf2b08b1f3"));
  } else {
    await Firebase.initializeApp();
  }
}
