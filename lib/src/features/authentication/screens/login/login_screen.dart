import 'package:flutter/material.dart';
import 'package:queue_ease/src/features/authentication/screens/login/login.widgets/login_form.dart';
import 'package:queue_ease/src/features/authentication/screens/login/login.widgets/login_header.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(QESizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              LoginHeader(),
              // Space
              SizedBox(
                height: QESizes.defaultSpace,
              ),
              // Form
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
