import 'package:flutter/material.dart';
import 'package:todo_list_app/components/app_button.dart';
import 'package:todo_list_app/components/background.dart';
import 'package:todo_list_app/components/color.dart';
import 'package:todo_list_app/screens/signup_screen.dart';

class StartedScreen extends StatefulWidget {
  const StartedScreen({super.key});

  @override
  State<StartedScreen> createState() => _StartedScreenState();
}

class _StartedScreenState extends State<StartedScreen> {
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
                      "assets/splash.png",
                      height: 300,
                      width: 300,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Text(
                    "Get Things Done With To-dos",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor,
                      fontFamily: 'Jaro',
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: AppColors.mainColor,
                      fontFamily: 'Jaro',
                    ),
                  ),
                  SizedBox(height: height * 0.06),
                  SizedBox(
                    child: AppButton(
                      text: "Get Started",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ),
                        );
                      },
                    ),
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
