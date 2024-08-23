import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/database/db_helper.dart';
import 'package:task_management/models/user_model.dart';

import 'package:task_management/utils/routes/routes_name.dart';
import 'package:task_management/utils/utils.dart';

class LoginProvider with ChangeNotifier {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  bool _isLoading = false;
  bool _isShowPassword = true;

  bool get isLoading => _isLoading;
  bool get ishowPassword => _isShowPassword;

  void hidePass() {
    _isShowPassword = !_isShowPassword;
    notifyListeners();
  }

  Future<dynamic> loginMethod(context) async {
    _isLoading = true;
    notifyListeners();
    try {
      bool isLogged = await DatabaseHelper.instance
          .login(Users(userName: emailC.text, userPassword: passwordC.text));

      if (isLogged) {
        Utils.succesMessage(context, "Login successfully");
        Navigator.pushReplacementNamed(context, AppRoutesName.homeScreen);
        saveLoginState();
        emailC.clear();
        passwordC.clear();
      } else {
        Utils.errorMessage(context, "User does not exist");
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      Utils.errorMessage(context, e.toString());
      debugPrint(e.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  void saveLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
  }
}
