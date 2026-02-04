import 'package:flutter/material.dart';

class HamburgerButton extends StatelessWidget {
  const HamburgerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Scaffold.of(context).openDrawer();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildLine(28),
          SizedBox(height: 4),
          _buildLine(20),
          SizedBox(height: 4),
          _buildLine(28),
          SizedBox(height: 4),
          _buildLine(20),
        ],
      ),
    );
  }

  Widget _buildLine(double width) {
    return Container(
      height: 3,
      width: width,
      decoration: BoxDecoration(
        color: Color(0xFFF8F3CE),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
