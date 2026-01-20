import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:lpmi_manage/repository/user_repository.dart';

class ResetPasswordController extends ChangeNotifier {
  final _userRepository = UserRepository();

  final emailController = TextEditingController();
  final codeController = TextEditingController();
  final newPasswordController = TextEditingController();

  String? _message;
  String? get message => _message;

  bool _codeSent = false;
  bool get codeSent => _codeSent;

  String _generatedCode = '';
  String _emailForReset = '';

  Future<void> sendResetCode() async {
    _message = null;
    final email = emailController.text.trim();

    if (email.isEmpty) {
      _message = "Veuillez entrer une adresse email.";
      notifyListeners();
      return;
    }

    final user = await _userRepository.getUserByEmail(email);
    if (user == null) {
      _message = "Aucun utilisateur trouvé avec cet email.";
      notifyListeners();
      return;
    }

    _generatedCode = (100000 + Random().nextInt(900000)).toString();
    _emailForReset = email;
    _codeSent = true;

    // Simulation of sending an email by printing the code to the console.
    debugPrint('---- PASSWORD RESET CODE FOR $email: $_generatedCode ----');

    _message = "Un code a été envoyé à l'adresse $email.";
    notifyListeners();
  }

  Future<bool> verifyAndResetPassword() async {
    _message = null;
    final code = codeController.text.trim();
    final newPassword = newPasswordController.text;

    if (code.isEmpty || newPassword.isEmpty) {
      _message = "Veuillez entrer le code et le nouveau mot de passe.";
      notifyListeners();
      return false;
    }

    if (code != _generatedCode || emailController.text.trim() != _emailForReset) {
      _message = "Le code de réinitialisation est incorrect.";
      notifyListeners();
      return false;
    }

    if (newPassword.length < 8) {
      _message = "Le nouveau mot de passe doit contenir au moins 8 caractères.";
      notifyListeners();
      return false;
    }

    try {
      final hashedPassword = sha256.convert(utf8.encode(newPassword)).toString();
      await _userRepository.updatePassword(_emailForReset, hashedPassword);
      _message = "Mot de passe réinitialisé avec succès.";
      notifyListeners();
      return true;
    } catch (e) {
      _message = "Une erreur est survenue lors de la mise à jour.";
      notifyListeners();
      return false;
    }
  }
}
