// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';
// import 'package:todo_list_app/components/app_button.dart';
// import 'package:todo_list_app/components/background.dart';
// import 'package:todo_list_app/components/color.dart';
// import 'package:todo_list_app/components/text_form_field.dart';
// import 'package:todo_list_app/providers/user_provider.dart';
// import 'package:todo_list_app/screens/login_screen.dart';

// class SignupScreen extends StatefulWidget {
//    SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final _auth = FirebaseAuth.instance;

//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   bool _isLoading = false;

//   Future<void> _register() async {
//     if (_passwordController.text != _confirmPasswordController.text) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: Colors.red,
//           content: Text("Passwords do not match"),
//         ),
//       );
//       return;
//     }

//     setState(() => _isLoading = true);

//     try {
//       await _auth.createUserWithEmailAndPassword(
//         email: _emailController.text.trim(),
//         password: _passwordController.text.trim(),
//       );

//       // ✅ Save name in Provider (for app-wide access)
//       final userProvider = Provider.of<UserProvider>(context, listen: false);
//       userProvider.setUserName(_nameController.text.trim());

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: AppColors.mainColor,
//           content: Text(
//             "Account created successfully!",
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w400,
//               color: AppColors.btnTextColor,
//               fontFamily: 'Jaro',
//             ),
//           ),
//         ),
//       );

//       // ✅ Go to login screen
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => LoginScreen()),
//       );
//     } on FirebaseAuthException catch (e) {
//       String message = "Something went wrong!";
//       if (e.code == 'email-already-in-use') {
//         message = "This email is already registered.";
//       } else if (e.code == 'weak-password') {
//         message = "Password should be at least 6 characters.";
//       }

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: Colors.red,
//           content: Text(
//             message,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w400,
//               color: AppColors.whiteColor,
//               fontFamily: 'Jaro',
//             ),
//           ),
//         ),
//       );
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;

//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: Background(
//         child: Center(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 24.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SizedBox(height: height * 0.24),
//                   Text(
//                     "Welcome Onboard!",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.whiteColor,
//                       fontFamily: 'Jaro',
//                     ),
//                   ),
//                   Text(
//                     "Let's help you meet up your task",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.white,
//                       fontFamily: 'Jaro',
//                     ),
//                   ),
//                   SizedBox(height: height * 0.06),

//                   CustomTextFormField(
//                     controller: _nameController,
//                     hintText: "Enter Your Full Name",
//                   ),
//                   SizedBox(height: height * 0.03),

//                   CustomTextFormField(
//                     controller: _emailController,
//                     hintText: "Enter Your Email",
//                   ),
//                   SizedBox(height: height * 0.03),

//                   CustomTextFormField(
//                     controller: _passwordController,
//                     hintText: "Enter Password",
//                     obscureText: true,
//                   ),
//                   SizedBox(height: height * 0.03),

//                   CustomTextFormField(
//                     controller: _confirmPasswordController,
//                     hintText: "Confirm Password",
//                     obscureText: true,
//                   ),
//                   SizedBox(height: height * 0.04),

//                   _isLoading
//                       ? CircularProgressIndicator(color: AppColors.mainColor)
//                       : AppButton(text: "Register", onPressed: _register),

//                   SizedBox(height: height * 0.02),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Already have an account? ",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'Jaro',
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => LoginScreen(),
//                             ),
//                           );
//                         },
//                         child: Text(
//                           "Login",
//                           style: TextStyle(
//                             color: AppColors.mainColor,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Jaro',
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   // SizedBox(height: height * 0.01),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// Design 2

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/components/app_button.dart';
import 'package:todo_list_app/components/background.dart';
import 'package:todo_list_app/components/color.dart';
import 'package:todo_list_app/components/text_form_field.dart';
import 'package:todo_list_app/providers/user_provider.dart';
import 'package:todo_list_app/screens/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;

  Future<void> _register() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Please enter your name.",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.whiteColor,
              fontFamily: 'Jaro',
            ),
          ),
        ),
      );
      return;
    }

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Please enter your email address.",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.whiteColor,
              fontFamily: 'Jaro',
            ),
          ),
        ),
      );
      return;
    }

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Please enter your password.",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.whiteColor,
              fontFamily: 'Jaro',
            ),
          ),
        ),
      );
      return;
    }

    if (confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Please enter your confirm password.",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.whiteColor,
              fontFamily: 'Jaro',
            ),
          ),
        ),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Passwords do not match",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.whiteColor,
              fontFamily: 'Jaro',
            ),
          ),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

      await userCredential.user!.updateDisplayName(name);

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setUserName(_nameController.text.trim());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.mainColor,
          content: Text(
            "Account created successfully!",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.btnTextColor,
              fontFamily: 'Jaro',
            ),
          ),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == "email-already-in-use") {
        message = "This email is already registered.";
      } else if (e.code == "invalid-email") {
        message = "Invalid email address.";
      } else if (e.code == "weak-password") {
        message = "Password should be at least 8 characters.";
      } else {
        message = "Signup failed: ${e.message}";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            message,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.whiteColor,
              fontFamily: 'Jaro',
            ),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("An unexpected error occurred. Please try again."),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Background(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: height * 0.24),
                  Text(
                    "Welcome Onboard!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor,
                      fontFamily: 'Jaro',
                    ),
                  ),
                  Text(
                    "Let's help you meet up your task",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontFamily: 'Jaro',
                    ),
                  ),
                  SizedBox(height: height * 0.06),

                  CustomTextFormField(
                    controller: _nameController,
                    hintText: "Enter Your Full Name",
                  ),
                  SizedBox(height: height * 0.03),

                  CustomTextFormField(
                    controller: _emailController,
                    hintText: "Enter Your Email",
                  ),
                  SizedBox(height: height * 0.03),

                  CustomTextFormField(
                    controller: _passwordController,
                    hintText: "Enter Password",
                    obscureText: true,
                  ),
                  SizedBox(height: height * 0.03),

                  CustomTextFormField(
                    controller: _confirmPasswordController,
                    hintText: "Confirm Password",
                    obscureText: true,
                  ),
                  SizedBox(height: height * 0.04),

                  _isLoading
                      ? CircularProgressIndicator(color: AppColors.mainColor)
                      : AppButton(text: "Register", onPressed: _register),

                  SizedBox(height: height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Jaro',
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: AppColors.mainColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Jaro',
                          ),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(height: height * 0.01),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
