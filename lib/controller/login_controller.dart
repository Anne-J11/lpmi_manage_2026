import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:lpmi_manage/repository/user_repository.dart';

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

    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(emailController.text.trim())) {
      _errorMessage = "Veuillez entrer une adresse email valide.";
      notifyListeners();
      return false;
    }

    final user = await _userRepository.getUserByEmail(emailController.text.trim());

    if (user == null) {
      _errorMessage = "Aucun utilisateur trouvé avec cet email.";
      notifyListeners();
      return false;
    }

    final hashedPassword = sha256.convert(utf8.encode(passwordController.text)).toString();

    if (user.password != hashedPassword) {
      _errorMessage = "Le mot de passe est incorrect.";
      notifyListeners();
      return false;
    }

    return true;
  }
}
