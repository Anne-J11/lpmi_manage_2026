import 'package:flutter/cupertino.dart';

class LoginController extends ChangeNotifier{
  final TextEditingController emailController =
      TextEditingController();
  final TextEditingController passwordController =
  TextEditingController();

  Future<bool> checkLogin() async{
    await Future.delayed(const Duration(seconds: 2));
    return emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
  }
}