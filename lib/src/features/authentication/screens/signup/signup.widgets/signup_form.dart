import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:queue_ease/src/features/authentication/screens/signup/signup.widgets/signup_TOC.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';
import 'package:queue_ease/src/utils/constants/sizes.dart';
import 'package:queue_ease/src/utils/constants/text_strings.dart';
import 'package:queue_ease/src/utils/http/http_client.dart';
import 'package:queue_ease/src/utils/validators/validation.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  String? firstNameError;
  String? lastNameError;
  String? emailError;
  String? passwordError;
  String? phoneNoError;
  String? generalError;

  void registerUser() async {
    setState(() {
      generalError = null;
    });

    setState(() {
      firstNameError = QEValidator.validateFirstName(firstNameController.text);
      lastNameError = QEValidator.validateLastName(lastNameController.text);
      emailError = QEValidator.validateEmail(emailController.text);
      passwordError = QEValidator.validatePassword(passwordController.text);
      phoneNoError = QEValidator.validatePhoneNumber(phoneNoController.text);
    });

    if (firstNameError == null &&
        lastNameError == null &&
        emailError == null &&
        passwordError == null &&
        phoneNoError == null) {
      final Map<String, dynamic> data = {
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'phoneNumber': phoneNoController.text,
      };

      try {
        await QEHttpHelper.post('registration', data);
        setState(() {
          firstNameController.clear();
          lastNameController.clear();
          emailController.clear();
          passwordController.clear();
          phoneNoController.clear();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Signup successful',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            backgroundColor: QEColors.success,
          ),
        );
      } catch (error) {
        setState(() {
          generalError = 'Signup failed. Please try again later.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          // FirstName LastName
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: firstNameController,
                  expands: false,
                  decoration: InputDecoration(
                    labelText: QETexts.firstName,
                    prefixIcon: const Icon(CupertinoIcons.person),
                    errorText: firstNameError,
                  ),
                ),
              ),
              const SizedBox(
                width: QESizes.spaceBtwInputFields,
              ),
              Expanded(
                child: TextFormField(
                  controller: lastNameController,
                  expands: false,
                  decoration: InputDecoration(
                    labelText: QETexts.lastName,
                    prefixIcon: const Icon(CupertinoIcons.person),
                    errorText: lastNameError,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: QESizes.spaceBtwInputFields,
          ),

          // Email
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: QETexts.email,
              prefixIcon: const Icon(CupertinoIcons.mail),
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
            height: QESizes.spaceBtwInputFields,
          ),

          // PhoneNumber
          TextFormField(
            controller: phoneNoController,
            decoration: InputDecoration(
              labelText: QETexts.phoneNm,
              prefixIcon: const Icon(CupertinoIcons.phone),
              errorText: phoneNoError,
            ),
          ),

          const SizedBox(
            height: QESizes.spaceBtwSections,
          ),

          const SignupTOC(),

          const SizedBox(
            height: QESizes.spaceBtwSections,
          ),

          // General Error Message
          if (generalError != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                generalError!,
                style: const TextStyle(color: Colors.red),
              ),
            ),

          // Create Account Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: registerUser,
              child: const Text(QETexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
