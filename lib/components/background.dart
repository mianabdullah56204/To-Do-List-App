import 'package:flutter/material.dart';
import 'package:todo_list_app/components/color.dart';

class Background extends StatelessWidget {
  final Widget? child;
  const Background({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(decoration: BoxDecoration(gradient: AppColors.bgColor)),
        Positioned(
          top: -40,
          left: -80,
          child: Container(
            width: 230,
            height: 140,
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(200),
                bottomRight: Radius.circular(200),
              ),
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: -70,
          child: Container(
            width: 180,
            height: 180,
            decoration: const BoxDecoration(
              color: AppColors.mainColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        if (child != null) child!,
      ],
    );
  }
}
