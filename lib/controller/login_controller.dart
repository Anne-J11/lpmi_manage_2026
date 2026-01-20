import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:lpmi_manage/model/user.dart';
import 'package:lpmi_manage/repository/user_repository.dart';
import 'package:lpmi_manage/utils/validators.dart';

class LoginController extends ChangeNotifier {
  final _userRepository = UserRepository();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> checkLogin() async {
    _errorMessage = null;

    if (emailController.text.trim().isEmpty || passwordController.text.isEmpty) {
      _errorMessage = "L'email et le mot de passe sont obligatoires.";
      notifyListeners();
      return false;
    }

    if (!Validators.isValidEmail(emailController.text.trim())) {
      _errorMessage = "Veuillez entrer une adresse email valide.";
      notifyListeners();
      return false;
    }

    final user = await _userRepository.getUserByEmail(emailController.text.trim());

    if (user == null) {
      _errorMessage = "Email ou mot de passe incorrect.";
      notifyListeners();
      return false;
    }

    final hashedPassword = sha256.convert(utf8.encode(passwordController.text + user.salt)).toString();

    if (user.password != hashedPassword) {
      _errorMessage = "Email ou mot de passe incorrect.";
      notifyListeners();
      return false;
    }

    return true;
  }
}
