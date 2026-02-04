// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:todo_list_app/components/color.dart';
// import 'package:todo_list_app/components/profile_avatar.dart';
// import 'package:todo_list_app/components/upload_picture_dialog.dart';
// import 'package:todo_list_app/providers/user_provider.dart';

// class CustomDrawer extends StatefulWidget {
//   const CustomDrawer({super.key});

//   @override
//   State<CustomDrawer> createState() => _CustomDrawerState();
// }

// class _CustomDrawerState extends State<CustomDrawer> {
//   bool _isEditing = false;
//   late TextEditingController _nameController;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     // ✅ Safe place to read provider (initState me context unsafe hota hai)
//     final currentName = context.read<UserProvider>().userName;
//     _nameController = TextEditingController(text: currentName);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final userProvider = Provider.of<UserProvider>(context);

//     return Drawer(
//       width: 230,
//       backgroundColor: AppColors.mainColor,
//       shape: Border(left: BorderSide(style: BorderStyle.none)),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 14),
//         child: Column(
//           children: [
//             SizedBox(height: height * 0.015),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 InkWell(
//                   onTap: () => Navigator.pop(context),
//                   child: Container(
//                     width: 35,
//                     height: 35,
//                     decoration: BoxDecoration(
//                       color: AppColors.btnTextColor,
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     child: Center(
//                       child: Text(
//                         "X",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.mainColor,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: height * 0.03),

//             // Profile image
//             Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 ProfileAvatar(),

//                 Positioned(
//                   right: 6,
//                   bottom: -4,
//                   child: CircleAvatar(
//                     radius: 20,
//                     backgroundColor: AppColors.addTask,
//                     child: IconButton(
//                       onPressed: () {
//                         showDialog(
//                           context: context,
//                           builder: (_) => UploadPictureDialog(),
//                         );
//                       },
//                       icon: Icon(Icons.camera_alt, color: AppColors.mainColor),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(height: height * 0.03),

//             // 👇 Name or Editable Field
//             if (!_isEditing)
//               Text(
//                 userProvider.userName,
//                 style: TextStyle(
//                   color: AppColors.addTask,
//                   fontWeight: FontWeight.w400,
//                   fontSize: 20,
//                   fontFamily: "Jaro",
//                 ),
//               )
//             else
//               SizedBox(
//                 width: 170,
//                 height: 50,
//                 child: TextFormField(
//                   controller: _nameController,
//                   cursorColor: AppColors.btnTextColor,
//                   style: TextStyle(
//                     color: AppColors.btnTextColor,
//                     fontWeight: FontWeight.w400,
//                     fontFamily: 'Jaro',
//                   ),
//                   decoration: InputDecoration(
//                     hintText: "Enter your name",
//                     hintStyle: TextStyle(
//                       color: Colors.black54,
//                       fontWeight: FontWeight.normal,
//                       fontFamily: 'Jaro',
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(
//                         color: AppColors.addTask,
//                         width: 2.5,
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(
//                         color: AppColors.btnTextColor,
//                         width: 2.5,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(
//                         color: AppColors.btnTextColor,
//                         width: 2.5,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//             SizedBox(height: height * 0.02),

//             // 👇 Buttons (conditional)
//             if (!_isEditing)
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.btnTextColor,
//                   fixedSize: Size(170, 50),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     _isEditing = true;
//                   });
//                 },
//                 child: Text(
//                   'Edit Name',
//                   style: TextStyle(
//                     color: AppColors.mainColor,
//                     fontSize: 18,
//                     fontFamily: "Jaro",
//                   ),
//                 ),
//               )
//             else
//               Column(
//                 children: [
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.btnTextColor,
//                       fixedSize: const Size(170, 50),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isEditing = false;
//                         _nameController.text = userProvider.userName;
//                       });
//                     },
//                     child: Text(
//                       'Cancel',
//                       style: TextStyle(
//                         color: AppColors.mainColor,
//                         fontSize: 18,
//                         fontFamily: "Jaro",
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.addTask,
//                       fixedSize: Size(170, 50),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     onPressed: () {
//                       final newName = _nameController.text.trim();
//                       if (newName.isNotEmpty) {
//                         userProvider.updateUserName(newName);
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             backgroundColor: AppColors.mainColor,
//                             content: Text(
//                               "Name updated to $newName",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400,
//                                 color: AppColors.btnTextColor,
//                                 fontFamily: 'Jaro',
//                               ),
//                             ),
//                             behavior: SnackBarBehavior.floating,
//                           ),
//                         );
//                       }
//                       setState(() {
//                         _isEditing = false;
//                       });
//                     },
//                     child: Text(
//                       'Save',
//                       style: TextStyle(
//                         color: AppColors.mainColor,
//                         fontSize: 18,
//                         fontFamily: "Jaro",
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Deisgn 2

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/components/color.dart';
import 'package:todo_list_app/components/profile_avatar.dart';
import 'package:todo_list_app/components/upload_picture_dialog.dart';
import 'package:todo_list_app/providers/user_provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _isEditing = false;
  late TextEditingController _nameController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final currentName = context.read<UserProvider>().userName;
    _nameController = TextEditingController(text: currentName);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final userProvider = Provider.of<UserProvider>(context);

    return Drawer(
      width: 230,
      elevation: 0,
      backgroundColor: Colors.transparent, // 🟡 keep transparent base
      shape: Border(left: BorderSide(style: BorderStyle.none)),
      child: SafeArea(
        child: Container(
          width: 230,
          decoration: BoxDecoration(
            color: AppColors.mainColor, // ✅ your drawer background
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(0),
              bottomRight: Radius.circular(0),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
                SizedBox(height: height * 0.015),

                // Close button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: AppColors.btnTextColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            "X",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: height * 0.03),

                // 🟡 Profile Avatar with edit button
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const ProfileAvatar(),
                    Positioned(
                      right: 6,
                      bottom: -4,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.addTask,
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => const UploadPictureDialog(),
                            );
                          },
                          icon: Icon(
                            Icons.camera_alt,
                            color: AppColors.mainColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: height * 0.03),

                // 🟡 Editable Name
                if (!_isEditing)
                  Text(
                    userProvider.userName,
                    style: TextStyle(
                      color: AppColors.addTask,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      fontFamily: "Jaro",
                    ),
                  )
                else
                  SizedBox(
                    width: 170,
                    height: 50,
                    child: TextFormField(
                      controller: _nameController,
                      cursorColor: AppColors.btnTextColor,
                      style: TextStyle(
                        color: AppColors.btnTextColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Jaro',
                      ),
                      decoration: InputDecoration(
                        hintText: "Enter your name",
                        hintStyle: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Jaro',
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: AppColors.addTask,
                            width: 2.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: AppColors.btnTextColor,
                            width: 2.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: AppColors.btnTextColor,
                            width: 2.5,
                          ),
                        ),
                      ),
                    ),
                  ),

                SizedBox(height: height * 0.02),

                // 🟡 Edit Buttons
                if (!_isEditing)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.btnTextColor,
                      fixedSize: const Size(170, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _isEditing = true;
                      });
                    },
                    child: Text(
                      'Edit Name',
                      style: TextStyle(
                        color: AppColors.mainColor,
                        fontSize: 18,
                        fontFamily: "Jaro",
                      ),
                    ),
                  )
                else
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.btnTextColor,
                          fixedSize: const Size(170, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _isEditing = false;
                            _nameController.text = userProvider.userName;
                          });
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: AppColors.mainColor,
                            fontSize: 18,
                            fontFamily: "Jaro",
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.addTask,
                          fixedSize: const Size(170, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          final newName = _nameController.text.trim();
                          if (newName.isNotEmpty) {
                            userProvider.updateUserName(newName);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.mainColor,
                                content: Text(
                                  "Name updated to $newName",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.btnTextColor,
                                    fontFamily: 'Jaro',
                                  ),
                                ),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                          setState(() {
                            _isEditing = false;
                          });
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: AppColors.mainColor,
                            fontSize: 18,
                            fontFamily: "Jaro",
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
