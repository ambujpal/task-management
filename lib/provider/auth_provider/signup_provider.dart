import 'package:flutter/material.dart';
import 'package:task_management/database/db_helper.dart';
import 'package:task_management/models/user_model.dart';
import 'package:task_management/utils/utils.dart';

class SignupProvider with ChangeNotifier {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  bool _isLoading = false;
  bool _isShowPassword = true;

  bool get ishowPassword => _isShowPassword;

  bool get isLoading => _isLoading;

  hidePass() {
    _isShowPassword = !_isShowPassword;
    notifyListeners();
  }

  Future<dynamic> signupMethod(context) async {
    _isLoading = true;
    notifyListeners();
    try {
      debugPrint("${emailC.text} ${passwordC.text}");
      await DatabaseHelper.instance
          .signup(Users(userName: emailC.text, userPassword: passwordC.text));
      Utils.succesMessage(context, "Register successfully");
      emailC.clear();
      passwordC.clear();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      Utils.errorMessage(context, e.toString());
      _isLoading = false;
      notifyListeners();
    }
  }
}
