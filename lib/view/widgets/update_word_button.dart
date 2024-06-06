import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/style/color_manager.dart';

class UpdataWordButton extends StatelessWidget {
  const UpdataWordButton({super.key, required this.color, required this.onTap});

  final Color color;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 35,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: const Icon(
          Icons.add,
          color: ColorManager.black,
        ),
      ),
    );
  }
}
