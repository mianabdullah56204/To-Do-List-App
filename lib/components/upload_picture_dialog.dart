import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/components/color.dart';
import 'package:todo_list_app/providers/user_provider.dart';

class UploadPictureDialog extends StatelessWidget {
  const UploadPictureDialog({super.key});

  Future<void> _pickFromGallery(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.isNotEmpty) {
      final path = result.files.single.path!;
      print("📂 Selected File: $path");

      // Save image path globally
      Provider.of<UserProvider>(context, listen: false).setProfileImage(path);

      Navigator.pop(context);
    }
  }

  Future<void> _openCamera(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      print("📸 Captured Image: ${pickedFile.path}");

      // Save image path globally
      Provider.of<UserProvider>(
        context,
        listen: false,
      ).setProfileImage(pickedFile.path);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.mainColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Upload Picture",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontFamily: "Jaro",
              ),
            ),
            SizedBox(height: 20),

            DottedBorder(
              color: Color(0xFF7A7A73),
              strokeWidth: 1.5,
              dashPattern: [4, 4],
              borderType: BorderType.RRect,
              radius: Radius.circular(10),
              child: Container(
                height: 240,
                width: double.infinity,
                color: AppColors.mainColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => _pickFromGallery(context),
                      child: Icon(
                        Icons.cloud_upload_outlined,
                        size: 40,
                        color: const Color.fromARGB(255, 130, 156, 155),
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => _pickFromGallery(context),
                      child: Text(
                        "Tap to Upload Photo",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.addTask,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Jaro",
                        ),
                      ),
                    ),

                    Text(
                      "Png, Jpeg or Pdf file",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Jaro",
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Or",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Jaro",
                      ),
                    ),

                    SizedBox(height: 15),

                    // 🔹 Camera Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.addTask,
                        fixedSize: Size(170, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => _openCamera(context),
                      child: Text(
                        "Open Camera",
                        style: TextStyle(
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          fontFamily: "Jaro",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
