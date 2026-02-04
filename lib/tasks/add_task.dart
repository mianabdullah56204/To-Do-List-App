import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/components/analog_clock.dart';
import 'package:todo_list_app/components/app_button.dart';
import 'package:todo_list_app/components/background.dart';
import 'package:todo_list_app/components/custom_drawer.dart';
import 'package:todo_list_app/components/hamburger_button.dart';
import 'package:todo_list_app/components/profile_avatar.dart';
import 'package:todo_list_app/components/text_form_field.dart';
import 'package:todo_list_app/helper/task_storage.dart';
import 'package:todo_list_app/providers/user_provider.dart';
import 'package:todo_list_app/tasks/daily_task.dart';

class AddTask extends StatefulWidget {
  final List<String> activities;
  const AddTask({super.key, required this.activities});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();
  // bool _isDrawerOpen = false;

  final TextEditingController _controller = TextEditingController();

  void _toast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.red, content: Text(message)),
    );
  }

  Future<void> _addActivity([String? preset]) async {
    final text = (preset ?? _controller.text).trim();
    if (text.isEmpty) {
      _toast('Please enter your task first.');
      return;
    }

    HapticFeedback.selectionClick();

    setState(() {
      widget.activities.add(text); // 🔹 ab purani wali list update hogi
      _controller.clear();
    });

    // ✅ Save tasks permanently
    await TaskStorage.saveTasks(widget.activities);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DailyTask(tasks: widget.activities),
      ),
    );
  }

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
                  // SizedBox(height: height * 0.02),
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
                  SizedBox(height: height * 0.04),
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

                  SizedBox(height: height * 0.04),
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

                  CustomTextFormField(
                    controller: _controller,
                    hintText: "Enter Your Task",
                  ),
                  SizedBox(height: height * 0.03),
                  SizedBox(
                    child: AppButton(text: "Add Task", onPressed: _addActivity),
                  ),
                  SizedBox(height: height * 0.01),

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
