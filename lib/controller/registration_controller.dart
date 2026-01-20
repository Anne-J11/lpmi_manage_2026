import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:lpmi_manage/model/user.dart';
import 'package:lpmi_manage/repository/user_repository.dart';
import 'package:lpmi_manage/utils/validators.dart';

class RegistrationController extends ChangeNotifier {
  final _userRepository = UserRepository();

  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String _generateSalt([int length = 32]) {
    final random = Random.secure();
    final values = List<int>.generate(length, (i) => random.nextInt(256));
    return base64Url.encode(values);
  }

  Future<bool> registerUser() async {
    _errorMessage = null;

    if (nomController.text.trim().isEmpty ||
        prenomController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      _errorMessage = "Tous les champs sont obligatoires.";
      notifyListeners();
      return false;
    }

    if (!Validators.isValidEmail(emailController.text.trim())) {
      _errorMessage = "Veuillez entrer une adresse email valide.";
      notifyListeners();
      return false;
    }

    final passwordError = Validators.validatePassword(passwordController.text);
    if (passwordError != null) {
      _errorMessage = passwordError;
      notifyListeners();
      return false;
    }

    final existingUser = await _userRepository.getUserByEmail(emailController.text.trim());
    if (existingUser != null) {
      _errorMessage = "Cette adresse email est déjà utilisée.";
      notifyListeners();
      return false;
    }

    final salt = _generateSalt();
    final hashedPassword = sha256.convert(utf8.encode(passwordController.text + salt)).toString();

    final newUser = User(
      nom: nomController.text.trim(),
      prenom: prenomController.text.trim(),
      email: emailController.text.trim(),
      password: hashedPassword,
      salt: salt,
    );

    try {
      await _userRepository.insertUser(newUser);
      return true;
    } catch (e) {
      _errorMessage = "Une erreur est survenue lors de l'inscription.";
      notifyListeners();
      return false;
    }
  }
}
