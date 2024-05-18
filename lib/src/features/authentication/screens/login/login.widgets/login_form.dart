// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:queue_ease/src/features/booking/screens/home/home_screen.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';
import 'package:queue_ease/src/utils/constants/text_strings.dart';
import 'package:queue_ease/src/utils/http/http_client.dart';
import 'package:queue_ease/src/utils/validators/validation.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? emailError;
  String? passwordError;

  void loginUser() async {
    setState(() {
      emailError = QEValidator.validateEmail(emailController.text);
      passwordError = QEValidator.validatePassword(passwordController.text);
    });

    if (emailError == null && passwordError == null) {
      final Map<String, dynamic> data = {
        'email': emailController.text,
        'password': passwordController.text,
      };

      try {
        final response = await QEHttpHelper.post('login', data);
        if (response['status']) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Login successful',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              backgroundColor: QEColors.success,
            ),
          );
          var myToken = response['token'];
          var box = await Hive.openBox('localData');
          await box.put('token', myToken);
          Get.offAll(() => HomeScreen(token: myToken));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                response['error'] ?? 'Login failed. Please try again later.',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Login failed. Please try again later.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            backgroundColor: Colors.red,
          ),
        );
        print(error);
      }
    }
  }

  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          // Email
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: QETexts.email,
              prefixIcon: const Icon(Icons.mail),
              errorText: emailError,
            ),
          ),

          const SizedBox(
            height: QESizes.spaceBtwInputFields,
          ),

          // Password
          TextFormField(
            controller: passwordController,
            obscureText: !isPasswordVisible,
            decoration: InputDecoration(
              labelText: QETexts.password,
              prefixIcon: const Icon(CupertinoIcons.lock),
              suffixIcon: GestureDetector(
                onTap: togglePasswordVisibility,
                child: Icon(
                  isPasswordVisible
                      ? CupertinoIcons.eye
                      : CupertinoIcons.eye_slash,
                ),
              ),
              errorText: passwordError,
            ),
          ),

          const SizedBox(
            height: QESizes.spaceBtwSections,
          ),

          // Login Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: loginUser,
              child: const Text(QETexts.logIn),
            ),
          ),
        ],
      ),
    );
  }
}
