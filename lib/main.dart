import 'package:Healthlogger/auth/login_page.dart';
import 'package:Healthlogger/auth/register_page.dart';
import 'package:Healthlogger/auth/splash_page.dart';
import 'package:Healthlogger/home/health_logger_page.dart';
import 'package:Healthlogger/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Logger',
      theme: ThemeData(
        primaryColor: Colors.amberAccent,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context)=> const SplashPage(),
        '/login': (context)=> const LoginPage(),
        '/register': (context)=> const RegisterPage(),
        '/home': (context)=> const HomePage(),
        '/logger': (context)=> const HealthLoggerPage(),
      },
    );
  }
}