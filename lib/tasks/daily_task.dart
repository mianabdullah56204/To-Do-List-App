import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/components/analog_clock.dart';
import 'package:todo_list_app/components/background.dart';
import 'package:todo_list_app/components/custom_drawer.dart';
import 'package:todo_list_app/components/hamburger_button.dart';
import 'package:todo_list_app/components/profile_avatar.dart';
import 'package:todo_list_app/components/task_list.dart';
import 'package:todo_list_app/providers/user_provider.dart';

class DailyTask extends StatefulWidget {
  final List<String> tasks;
  const DailyTask({super.key, required this.tasks});

  @override
  State<DailyTask> createState() => _DailyTaskState();
}

class _DailyTaskState extends State<DailyTask> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();
  // bool _isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      // backgroundColor: AppColors.mainColor, // NOT white
      // drawerScrimColor: Colors.black.withOpacity(0.3), // smooth overlay
      resizeToAvoidBottomInset: true,
      key: _drawerKey,
      drawer: CustomDrawer(),
      // onDrawerChanged: (isOpened) {
      //   setState(() {
      //     _isDrawerOpen = isOpened;
      //   });
      // },
      body: Background(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: height * 0.05),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [HamburgerButton()],
                  ),
                  SizedBox(height: height * 0.06),

                  ProfileAvatar(),

                  SizedBox(height: height * 0.02),
                  Text(
                    "Welcome  ${context.watch<UserProvider>().userName}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Jaro',
                    ),
                  ),
                  SizedBox(height: height * 0.05),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Good Morning",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          fontFamily: 'Jaro',
                        ),
                      ),
                    ],
                  ),

                  CustomAnalogClock(),

                  SizedBox(height: height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Enter Your Task",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Jaro',
                        ),
                      ),
                    ],
                  ),

                  TaskList(tasks: widget.tasks),

                  SizedBox(height: height * 0.02),

                  // if (_isDrawerOpen)
                  //   Positioned.fill(
                  //     child: BackdropFilter(
                  //       filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                  //       child: Container(color: Colors.black.withAlpha(50)),
                  //     ),
                  //   ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
