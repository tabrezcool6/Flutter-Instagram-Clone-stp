// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/services/firebase/firebase_auth_services.dart';
import 'package:instagram_clone/services/image_picker_services.dart';
import 'package:instagram_clone/source/screens/responsive/mobile_layout.dart';
import 'package:instagram_clone/source/screens/responsive/responsive_screen.dart';
import 'package:instagram_clone/source/screens/responsive/web_layout.dart';
import 'package:instagram_clone/source/widgets/input_text_field.dart';
import 'package:instagram_clone/source/widgets/primary_button.dart';
import 'package:instagram_clone/utils/constants.dart';
import 'package:instagram_clone/utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  Uint8List? _imageFile;

  bool isLoading = false;

  ///
  /// Dispose Controllers
  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
  }

  ///
  /// Login Button Method
  void _loginButtonMethod() {
    Navigator.pop(context);
    print('This is a Login Funtion');
  }

  ///
  /// Sign Up Button Method
  void _signUpButtonMethod() async {
    if (_key.currentState!.validate()) {
      if (_imageFile == null) {
        Utils.showSnackBar(context, 'No image selected');
      } else {
        setState(() {
          isLoading = true;
        });
        String result = await FirebaseAuthServices().signUp(
          username: _usernameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          bio: _bioController.text,
          file: _imageFile!,
        );
        setState(() {
          isLoading = false;
        });
        if (result == 'success') {
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
          Utils.showSnackBar(context, result);
        }
      }
    }
  }

  ///
  /// Upload Profile Picture Button Method
  void addProfilePhotoMethod() async {
    Uint8List imgFile =
        await ImagePickerServices.pickImage(ImageSource.gallery);
    setState(() {
      _imageFile = imgFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Form(
              key: _key,
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Spacer,
                      // Flexible(
                      //   flex: 1,
                      //   child: Container(),
                      // ),

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

                      Stack(
                        children: [
                          _imageFile != null
                              ? CircleAvatar(
                                  radius: 64,
                                  backgroundImage: MemoryImage(_imageFile!),
                                )
                              : const CircleAvatar(
                                  radius: 64,
                                  backgroundImage: NetworkImage(
                                    DEFAULT_PROFILE_PICTURE,
                                  ),
                                ),
                          Positioned(
                            bottom: -5.0,
                            right: -10.0,
                            child: IconButton(
                              onPressed: addProfilePhotoMethod,
                              icon: const Icon(
                                Icons.add_a_photo,
                              ),
                            ),
                          )
                        ],
                      ),

                      // Spacer
                      const SizedBox(
                        height: 24,
                      ),

                      // Username Text Field
                      InputTextField(
                        controller: _usernameController,
                        inputType: TextInputType.text,
                        hintText: 'Username',
                      ),

                      // Spacer
                      const SizedBox(
                        height: 24,
                      ),

                      // Email Text Field
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

                      // Bio Text Field
                      InputTextField(
                        controller: _bioController,
                        inputType: TextInputType.text,
                        hintText: 'Bio',
                      ),

                      // Spacer
                      const SizedBox(
                        height: 24,
                      ),

                      // Login Button
                      PrimaryButton(
                        title: 'Create Account',
                        onTap: _signUpButtonMethod,
                        isLoading: isLoading,
                      ),

                      // Spacer
                      // Flexible(
                      //   flex: 1,
                      //   child: Container(),
                      // ),

                      // Move to SignUp Page
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: const Text('Already have an account? '),
                          ),
                          GestureDetector(
                            onTap: _loginButtonMethod,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: const Text(
                                'Login',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom))
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
