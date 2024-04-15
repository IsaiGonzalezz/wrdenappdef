import 'package:flutter/material.dart';
//import 'package:warden_techsecure/pages/central_pages.dart';
import 'package:warden_techsecure/pages/auth_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'home': (context) => AuthScreen(),
        });
  }
}
