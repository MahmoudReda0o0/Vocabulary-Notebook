import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/style/color_manager.dart';

class DoneButton extends StatelessWidget {
  DoneButton({super.key, required this.colorCode, required this.onTap});

  int colorCode;
  VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              'Done',
              style: TextStyle(
                color: Color(colorCode),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
