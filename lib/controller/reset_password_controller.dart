import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:lpmi_manage/repository/user_repository.dart';
import 'package:lpmi_manage/utils/validators.dart';

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

    debugPrint('---- CODE DE RÉINITIALISATION POUR $email: $_generatedCode ----');

    _message = "Un code a été envoyé à l'adresse $email (vérifiez la console de débogage).";
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

    if (code != _generatedCode) {
      _message = "Le code de réinitialisation est incorrect.";
      notifyListeners();
      return false;
    }

    final passwordError = Validators.validatePassword(newPassword);
    if (passwordError != null) {
      _message = passwordError;
      notifyListeners();
      return false;
    }

    try {
      final user = await _userRepository.getUserByEmail(_emailForReset);
      if (user == null) throw Exception("User not found during password update");

      final hashedPassword = sha256.convert(utf8.encode(newPassword + user.salt)).toString();
      
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
