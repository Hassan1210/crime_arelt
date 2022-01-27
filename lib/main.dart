import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crimealert/login_system/wellcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:crimealert/home.dart';
import 'package:crimealert/Dashborad/Home_Page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: FirebaseAuth.instance.currentUser==null? 'WelcomeScreen' : 'Home',
      routes: {
        'WelcomeScreen' : (context) => WellcomeScreen(),
        'Home' : (context) => Home(),
      },
    );
  }
}
