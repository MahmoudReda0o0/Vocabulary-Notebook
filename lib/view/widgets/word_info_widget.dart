import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/view/style/color_manager.dart';

class WordInfoWidget extends StatelessWidget {
  const WordInfoWidget({
    super.key,
    required this.color,
    required this.isArabic,
    required this.text,
    this.onPressed,
  });
  final Color color;
  final String text;
  final bool isArabic;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: _getBoxDecoration(),
      child: Row(
        children: [
          _getIsArabicWidget(),
          const SizedBox(width: 10),
          Expanded(child: _getTextWidget()),
          if (onPressed != null)
            IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
        ],
      ),
    );
  }

  Text _getTextWidget() => Text(
        text,
        style: const TextStyle(
            color: ColorManager.black, fontWeight: FontWeight.bold),
      );

  CircleAvatar _getIsArabicWidget() {
    return CircleAvatar(
      radius: 25,
      backgroundColor: ColorManager.black,
      child: Text(
        isArabic ? 'Ar' : 'En',
        style: TextStyle(
          color: color,
        ),
      ),
    );
  }

  BoxDecoration _getBoxDecoration() {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(30),
    );
  }
}
