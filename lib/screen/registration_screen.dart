import 'package:flutter/material.dart';
import 'package:lpmi_manage/component/custom_button.dart';
import 'package:lpmi_manage/screen/login_screen.dart';

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
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Inscription"),
                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Nom",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Prénom",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "E-mail",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Mot de passe",
                      border: OutlineInputBorder(),
                    ),
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
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                          ),
                        ),
                      ),

                      Expanded(
                        child: ListTile(
                          title: const Text("Feminin"),
                          leading: Radio<Gender>(
                            value: Gender.feminin,
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                CustomButton(
                  elevatedButtonText: "S'inscrire",
                  textButtonText: "Déjà un compte ? Se connecter",
                  elevatedButtonClicked: () {},
                  textButtonClicked: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
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
