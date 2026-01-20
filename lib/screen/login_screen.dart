import 'package:flutter/material.dart';
import 'package:lpmi_manage/controller/login_controller.dart';
import 'package:lpmi_manage/component/custom_button.dart';
import 'package:lpmi_manage/screen/home_screen.dart';
import 'package:lpmi_manage/screen/registration_screen.dart';
import 'package:lpmi_manage/screen/reset_password_screen.dart';
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
    );

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Connexion", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              if (loginController.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    loginController.errorMessage!,
                    style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: loginController.emailController,
                  decoration: const InputDecoration(
                    labelText: "E-mail",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: loginController.passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Mot de passe",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ResetPasswordScreen()),
                    );
                  },
                  child: const Text('Mot de passe oublié ?'),
                ),
              ),
              CustomButton(
                elevatedButtonText: "Se connecter",
                textButtonText: "Pas de compte ? S'inscrire",
                elevatedButtonClicked: () async {
                  final isLoggedIn = await loginController.checkLogin();
                  if (isLoggedIn) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Connexion réussie")),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  }
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
      ),
    );
  }
}
