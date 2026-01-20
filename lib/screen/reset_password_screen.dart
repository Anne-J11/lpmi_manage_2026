import 'package:flutter/material.dart';
import 'package:lpmi_manage/controller/reset_password_controller.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResetPasswordController(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Réinitialiser le mot de passe")),
        body: Consumer<ResetPasswordController>(
          builder: (context, controller, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (controller.message != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        controller.message!,
                        style: TextStyle(
                          color: controller.message!.contains("succès") ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (!controller.codeSent)
                    _buildEmailEntry(context, controller)
                  else
                    _buildCodeAndNewPasswordEntry(context, controller),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmailEntry(BuildContext context, ResetPasswordController controller) {
    return Column(
      children: [
        SizedBox(
          width: 300,
          child: TextField(
            controller: controller.emailController,
            decoration: const InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: controller.sendResetCode,
          child: const Text("Envoyer le code"),
        ),
      ],
    );
  }

  Widget _buildCodeAndNewPasswordEntry(BuildContext context, ResetPasswordController controller) {
    return Column(
      children: [
        SizedBox(
          width: 300,
          child: TextField(
            controller: controller.codeController,
            decoration: const InputDecoration(
              labelText: "Code de réinitialisation",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: 300,
          child: TextField(
            controller: controller.newPasswordController,
            decoration: const InputDecoration(
              labelText: "Nouveau mot de passe",
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            final success = await controller.verifyAndResetPassword();
            if (success) {
              Future.delayed(const Duration(seconds: 2), () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              });
            }
          },
          child: const Text("Réinitialiser le mot de passe"),
        ),
      ],
    );
  }
}
