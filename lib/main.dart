import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:trace_app_3a/screens/login.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(TraceApp());
}

//!!! TRACE APP
//!1) Register account a) client/visitor b) establishment - Firebase Auth
//!2) Login -Auth
//3) Generate QR Code - qr package
//4) Scan QR Code - qr
//5) Log/Trace - Firebase Firestore

class TraceApp extends StatelessWidget {
  const TraceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      builder: EasyLoading.init(),
    );
  }
}
