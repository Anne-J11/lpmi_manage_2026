import 'package:flutter/cupertino.dart';

class RegistrationController extends ChangeNotifier{
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<bool> checkLogin() async{
    await Future.delayed(const Duration(seconds: 2));
    return nomController.text.isNotEmpty &&
        prenomController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }
}