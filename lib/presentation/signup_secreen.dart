import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/provider/auth_provider/signup_provider.dart';
import 'package:task_management/style/app_text_style.dart';
import 'package:task_management/utils/routes/routes_name.dart';
import 'package:task_management/widgets/custom_elevated_btn.dart';
import 'package:task_management/widgets/custom_textformfield.dart';

class SignupSecreen extends StatefulWidget {
  const SignupSecreen({super.key});

  @override
  State<SignupSecreen> createState() => _SignupSecreenState();
}

class _SignupSecreenState extends State<SignupSecreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<SignupProvider>(builder: (context, provider, child) {
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
                    "Register",
                    style: AppTextStyle.ts18MB.copyWith(fontSize: 22),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  CustomTextFormField(
                    controller: provider.emailC,
                    textInputType: TextInputType.emailAddress,
                    labelText: "Email",
                    hintText: "Enter your email",
                    prefixIcon: Icons.email,
                  ),
                  const SizedBox(height: 30.0),
                  CustomTextFormField(
                    controller: provider.passwordC,
                    obscureText: provider.ishowPassword,
                    textInputType: TextInputType.number,
                    labelText: "Password",
                    hintText: "Enter your password",
                    prefixIcon: Icons.lock,
                    suffixIcon: provider.ishowPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    suffixIconOnTap: () => provider.hidePass(),
                  ),
                  const SizedBox(height: 50.0),
                  CustomElevatedBtn(
                    title: "SIGN UP",
                    bgColor: Colors.orange,
                    isLoading: provider.isLoading,
                    indicatorColor: Colors.white,
                    onTap: () async {
                      provider.signupMethod(context);
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Already have an account?",
                        style: AppTextStyle.ts14RB,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppRoutesName.loginScreen);
                        },
                        child: Text(
                          "Login",
                          style:
                              AppTextStyle.ts16RB.copyWith(color: Colors.blue),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
