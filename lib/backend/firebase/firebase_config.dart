import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyA_SyJHGvtl-djbyNikQZNENWNOBPi44nA",
            authDomain: "agrolinkbase.firebaseapp.com",
            projectId: "agrolinkbase",
            storageBucket: "agrolinkbase.appspot.com",
            messagingSenderId: "344896830940",
            appId: "1:344896830940:web:ed625a58881f37f789a319",
            measurementId: "G-5CWVBC6V59"));
  } else {
    await Firebase.initializeApp();
  }
}
