import 'package:flutter/material.dart';
import 'package:lpmi_manage/component/custom_button.dart';
import 'package:lpmi_manage/controller/registration_controller.dart';
import 'package:lpmi_manage/screen/login_screen.dart';
import 'package:provider/provider.dart';

enum Gender { masculin, feminin }

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  Gender? _selectedGender;

  @override
  Widget build(BuildContext context) {
    final registrationController = Provider.of<RegistrationController>(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Inscription", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),

                if (registrationController.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      registrationController.errorMessage!,
                      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),

                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: registrationController.nomController,
                    decoration: const InputDecoration(labelText: "Nom", border: OutlineInputBorder()),
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: registrationController.prenomController,
                    decoration: const InputDecoration(labelText: "Prénom", border: OutlineInputBorder()),
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: registrationController.emailController,
                    decoration: const InputDecoration(labelText: "E-mail", border: OutlineInputBorder()),
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: registrationController.passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: "Mot de passe", border: OutlineInputBorder()),
                  ),
                ),

                SizedBox(
                  width: 325,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ListTile(
                          title: const Text("Masculin"),
                          leading: Radio<Gender>(
                            value: Gender.masculin,
                            groupValue: _selectedGender,
                            onChanged: (value) => setState(() => _selectedGender = value),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text("Féminin"),
                          leading: Radio<Gender>(
                            value: Gender.feminin,
                            groupValue: _selectedGender,
                            onChanged: (value) => setState(() => _selectedGender = value),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                CustomButton(
                  elevatedButtonText: "S'inscrire",
                  textButtonText: "Déjà un compte ? Se connecter",
                  elevatedButtonClicked: () async {
                    final isRegistered = await registrationController.registerUser();
                    if (isRegistered) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Inscription réussie !")),
                      );
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                            (Route<dynamic> route) => false,
                      );
                    }
                  },
                  textButtonClicked: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
