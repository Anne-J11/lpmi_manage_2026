import 'package:flutter/material.dart';
import 'package:lpmi_manage/screen/login_screen.dart';
import 'package:lpmi_manage/screen/registration_screen.dart';

class WelcomeScreen extends StatefulWidget{
  const WelcomeScreen({super.key});
  @override
  State<WelcomeScreen> createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Image.asset("assets/logo.png", width: 100),
            const SizedBox(height: 50),
            const Text("Bienvenue sur l'app LPMI Manage"),
            const SizedBox(height: 50),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationScreen()));}
                , child: Text("Sinscrire")),

            const SizedBox(height: 50),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            }, child: Text("Se connecter")),
          ],
        )
      )
    );
  }
}