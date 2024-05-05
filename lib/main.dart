
import 'package:blog_app/view/login/login_view.dart';
import 'package:blog_app/view/register/register_view.dart';
import 'package:blog_app/view/welcome/welcome_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const WelcomeView(),
    );
  }
}