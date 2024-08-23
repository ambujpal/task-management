import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/presentation/signup_secreen.dart';
import 'package:task_management/provider/auth_provider/login_provider.dart';
import 'package:task_management/style/app_text_style.dart';
import 'package:task_management/widgets/custom_elevated_btn.dart';
import 'package:task_management/widgets/custom_textformfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Consumer<LoginProvider>(builder: (context, provider, child) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Text(
                  "Login",
                  style: AppTextStyle.ts18MB.copyWith(fontSize: 22),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                CustomTextFormField(
                  controller: provider.emailC,
                  textInputType: TextInputType.emailAddress,
                  hintText: "Enter your email",
                  prefixIcon: Icons.email,
                  labelText: 'Email',
                ),
                const SizedBox(height: 30.0),
                CustomTextFormField(
                  controller: provider.passwordC,
                  obscureText: provider.ishowPassword,
                  textInputType: TextInputType.number,
                  labelText: 'Password',
                  hintText: "Enter your password",
                  prefixIcon: Icons.lock,
                  suffixIcon: provider.ishowPassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                  suffixIconOnTap: provider.hidePass,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                CustomElevatedBtn(
                  title: "Login",
                  indicatorColor: Colors.white,
                  bgColor: Colors.orange,
                  isLoading: provider.isLoading,
                  onTap: () async {
                    provider.loginMethod(context);
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "Don't have an account?",
                      style: AppTextStyle.ts14RB,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupSecreen()));
                        },
                        child: Text(
                          "Create account",
                          style:
                              AppTextStyle.ts16RB.copyWith(color: Colors.blue),
                        ))
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      );
    }));
  }
}
