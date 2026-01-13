import 'package:flutter/material.dart';
import 'package:lpmi_manage/controller/login_controller.dart';
import 'package:lpmi_manage/component/custom_button.dart';
import 'package:lpmi_manage/screen/home_screen.dart';
import 'package:lpmi_manage/screen/registration_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(
      context,
      listen: false,
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Connexion"),

            SizedBox(
              height: 50,
              width: 300,
              child: TextField(
                controller: loginController.emailController,
                decoration: InputDecoration(
                  labelText: "E-mail",
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 50,
              width: 300,
              child: TextField(
                controller: loginController.passwordController,
                decoration: InputDecoration(
                  labelText: "Mot de passe",
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            const SizedBox(height: 20),

            CustomButton(
              elevatedButtonText: "Se connecter",
              textButtonText: "Pas de compte ? S'inscrire",
              elevatedButtonClicked: () {
                loginController.checkLogin().then((isLoggedIn) {
                  if (isLoggedIn) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Connexion réussie")),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Erreur de connexion")),
                    );
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                });
              },
              textButtonClicked: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegistrationScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
