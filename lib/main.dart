import 'package:flutter/material.dart';
import 'package:lpmi_manage/controller/home_controller.dart';
import 'package:lpmi_manage/controller/login_controller.dart';
import 'package:lpmi_manage/screen/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => HomeController()),
      ],
      child: MaterialApp(
      home: WelcomeScreen(),),
    );
  }
}
