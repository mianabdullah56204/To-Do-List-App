import 'package:flutter/material.dart';
import 'package:todo_list_app/components/background.dart';
import 'package:todo_list_app/components/color.dart';
import 'package:todo_list_app/screens/started_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => StartedScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Background(
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.mainColor,
            strokeAlign: 10,
            strokeWidth: 10,
          ),
        ),
      ),
    );
  }
}
