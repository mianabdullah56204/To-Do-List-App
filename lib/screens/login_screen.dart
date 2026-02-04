// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:todo_list_app/components/app_button.dart';
// import 'package:todo_list_app/components/background.dart';
// import 'package:todo_list_app/components/color.dart';
// import 'package:todo_list_app/components/text_form_field.dart';
// import 'package:todo_list_app/screens/signup_screen.dart';
// import 'package:todo_list_app/tasks/daily_task.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _auth = FirebaseAuth.instance;

//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   bool _isLoading = false;

//   Future<void> _login() async {
//     setState(() => _isLoading = true);

//     try {
//       await _auth.signInWithEmailAndPassword(
//         email: _emailController.text.trim(),
//         password: _passwordController.text.trim(),
//       );

//       // ✅ Login successful
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: AppColors.mainColor,
//           content: Text(
//             "Login successful!",
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w400,
//               color: AppColors.btnTextColor,
//               fontFamily: 'Jaro',
//             ),
//           ),
//         ),
//       );

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => DailyTask(tasks: [])),
//       );
//     } on FirebaseAuthException catch (e) {
//       String message = "Something went wrong!";
//       if (e.code == 'user-not-found') {
//         message = "No user found for this email.";
//       } else if (e.code == 'wrong-password') {
//         message = "Wrong password. Try again.";
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
//     final height = MediaQuery.of(context).size.height * 1;
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: Background(
//         child: Center(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 24.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SizedBox(height: height * 0.20),
//                   FittedBox(
//                     fit: BoxFit.cover,
//                     child: Image.asset(
//                       "assets/login.png",
//                       height: 300,
//                       width: 300,
//                     ),
//                   ),

//                   /// Text Fields
//                   SizedBox(height: height * 0.04),
//                   CustomTextFormField(
//                     controller: _emailController,
//                     hintText: "Enter Your Email",
//                   ),
//                   SizedBox(height: height * 0.02),
//                   CustomTextFormField(
//                     controller: _passwordController,
//                     hintText: "Enter Password",
//                     obscureText: true,
//                   ),

//                   SizedBox(height: height * 0.04),
//                   _isLoading
//                       ? CircularProgressIndicator(color: AppColors.mainColor)
//                       : AppButton(text: "Login", onPressed: _login),

//                   SizedBox(height: height * 0.02),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         "Don't have an account? ",
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
//                               builder: (context) => SignupScreen(),
//                             ),
//                           );
//                         },
//                         child: Text(
//                           "Sign Up",
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

// login: mianabdullah56204@gmail.com

// password: bali-786

// Design 2

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_app/components/app_button.dart';
import 'package:todo_list_app/components/background.dart';
import 'package:todo_list_app/components/color.dart';
import 'package:todo_list_app/components/text_form_field.dart';
import 'package:todo_list_app/screens/signup_screen.dart';
import 'package:todo_list_app/tasks/daily_task.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

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

    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DailyTask(tasks: [])),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.mainColor,
          behavior: SnackBarBehavior.floating,
          content: Text(
            "Login successful! Welcome back 👋",

            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.btnTextColor,
              fontFamily: 'Jaro',
            ),
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message;

      if (e.code == 'user-not-found') {
        message = "No account found with this email. Please sign up first.";
      } else if (e.code == 'invalid-email') {
        message = "Please enter a valid email address.";
      } else if (e.code == 'wrong-password') {
        message = "Incorrect password. Please try again.";
      } else if (e.code == 'user-disabled') {
        message = "This account has been disabled. Contact support.";
      } else if (e.code == 'too-many-requests') {
        message =
            "Too many failed attempts. Please wait a few minutes and try again.";
      } else if (e.code == 'network-request-failed') {
        message = "Network error. Check your internet connection.";
      } else {
        message = "Login failed. Please try again later.";
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
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Background(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: height * 0.20),
                  FittedBox(
                    fit: BoxFit.cover,
                    child: Image.asset(
                      "assets/login.png",
                      height: 300,
                      width: 300,
                    ),
                  ),

                  /// Text Fields
                  SizedBox(height: height * 0.04),
                  CustomTextFormField(
                    controller: _emailController,
                    hintText: "Enter Your Email",
                  ),
                  SizedBox(height: height * 0.02),
                  CustomTextFormField(
                    controller: _passwordController,
                    hintText: "Enter Password",
                    obscureText: true,
                  ),

                  SizedBox(height: height * 0.04),
                  _isLoading
                      ? CircularProgressIndicator(color: AppColors.mainColor)
                      : AppButton(text: "Login", onPressed: _login),

                  SizedBox(height: height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
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
                              builder: (context) => SignupScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign Up",
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

// login: mianabdullah56204@gmail.com

// password: bali-786
