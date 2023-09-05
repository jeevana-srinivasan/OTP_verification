import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import './screens/otp.dart';
import './screens/phone.dart';
import './screens/record.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          canvasColor: Colors.white,
          primaryColor: Colors.deepPurple,
          hintColor: Colors.white,
        ),
        initialRoute: 'phone',
        routes: {
          'phone': (context) => Phone(),
          'otp': (context) => Otp(),
          'record': (context) => Record(),
        });
  }
}
