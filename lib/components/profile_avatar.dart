import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/providers/user_provider.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final imagePath = userProvider.profileImagePath;

    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: imagePath != null
              ? FileImage(File(imagePath)) as ImageProvider
              : AssetImage("assets/profile.jpg"),
          fit: BoxFit.cover, // ✅ Ensures full fit, no zoom or crop issues
          alignment: Alignment.center, // ✅ Centers perfectly
        ),
      ),
    );
  }
}

// CircleAvatar(
//   radius: 70,
//   backgroundImage: imagePath != null
//       ? FileImage(File(imagePath)) // show uploaded image
//       : AssetImage("assets/profile.jpg")
//             as ImageProvider, // default image
// ),
