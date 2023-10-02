// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/services/firebase/firebase_auth_services.dart';
import 'package:instagram_clone/source/screens/authScreens/sign_up_screen.dart';
import 'package:instagram_clone/source/screens/responsive/mobile_layout.dart';
import 'package:instagram_clone/source/screens/responsive/responsive_screen.dart';
import 'package:instagram_clone/source/screens/responsive/web_layout.dart';
import 'package:instagram_clone/source/widgets/input_text_field.dart';
import 'package:instagram_clone/source/widgets/primary_button.dart';
import 'package:instagram_clone/utils/utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  //
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool isLoading = false;

  // Dispose Controllers
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  // Login Button Method
  void _loginButtonMethod() async {
    //
    if (_key.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      String res = await FirebaseAuthServices().login(
        email: _emailController.text,
        password: _passwordController.text,
      );
      setState(() {
        isLoading = false;
      });

      if (res == 'success') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobScreenLayout: MobileLayout(),
              webScreenLayout: WebLayout(),
            ),
          ),
        );
      } else {
        Utils.showSnackBar(context, res);
      }
    }
  }

  // Sign Up Button Method
  void _signUpButtonMethod() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  // Spacer,
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),

                  // Instagram logo
                  SvgPicture.asset(
                    'assets/instagram_logo.svg',
                    color: Colors.white,
                    height: 64,
                  ),

                  // Spacer
                  const SizedBox(
                    height: 64,
                  ),

                  // Username/Email Text Field
                  InputTextField(
                    controller: _emailController,
                    inputType: TextInputType.emailAddress,
                    hintText: 'E-mail',
                  ),

                  // Spacer
                  const SizedBox(
                    height: 24,
                  ),

                  // Password Text Field
                  InputTextField(
                    controller: _passwordController,
                    inputType: TextInputType.text,
                    hintText: 'Password',
                    obscureText: true,
                  ),

                  // Spacer
                  const SizedBox(
                    height: 24,
                  ),

                  // Login Button
                  PrimaryButton(
                    title: 'Login',
                    onTap: _loginButtonMethod,
                    isLoading: isLoading,
                  ),

                  // Spacer
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),

                  // Move to SignUp Page
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: const Text('Don\'t have an account? '),
                      ),
                      GestureDetector(
                        onTap: _signUpButtonMethod,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
