import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/style/color_manager.dart';

class ExceptionWidget extends StatelessWidget {
  const ExceptionWidget(
      {super.key, required this.iconData, required this.message});
  final IconData iconData;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          iconData,
          color: ColorManager.white,
          size: 60,
        ),
        const SizedBox(height: 15),
        Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: ColorManager.white,
            fontSize: 24,
          ),
        )
      ],
    );
  }
}
