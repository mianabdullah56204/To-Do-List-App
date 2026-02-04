import 'package:flutter/material.dart';
import 'package:todo_list_app/components/color.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.list_alt, size: 36, color: AppColors.btnTextColor),
          SizedBox(height: 8),
          Text(
            'No activities yet',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.btnTextColor,
              fontFamily: 'Jaro',
            ),
          ),
          SizedBox(height: 4),
          Text(
            'click on plus icon to add task',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: AppColors.btnTextColor,
              fontFamily: 'Jaro',
            ),
          ),
        ],
      ),
    );
  }
}
