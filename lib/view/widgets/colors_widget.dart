import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:flutter_application_1/view/style/color_manager.dart';

class ColorWidget extends StatelessWidget {
  const ColorWidget({super.key, required this.activeColorCode});

  final int activeColorCode;
  final List<int> _colorCodes = const [
    0xFF0000, // Red
    0xFFFF00, // Yellow
    0x00FF00, // Green
    0x0000FF, // Blue
    0xFFC0CB, // Pink
    0x800080, // Purple
    0xA52A2A, // Brown
    0xFFFFFF, // White
    0x000000, // Black
    0xC0C0C0, // Gray
    0xFFA500, // Orange
    0x00CED1, // Light Blue
    0x9CCC65, // Light Green
    0xADD8E6, // Light Blue (2)
    0xF08080, // Light Pink
    0xEE82EE, // Violet
    0xCD5B45, // Maroon
    0xEEE8AA, // Pale Yellow
    0x4CAF50, // Green (2)
    0x2196F3, // Blue (2)
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _colorCodes.length,
        itemBuilder: (context, index) => _getItemDesign(index, context),
        separatorBuilder: (context, int index) => const SizedBox(
          width: 8,
        ),
      ),
    );
  }

  Widget _getItemDesign(int index, BuildContext context) {
    return InkWell(
      onTap: () =>
          WriteDataCubit.get(context).updataColorCode(_colorCodes[index]),
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          border: activeColorCode == _colorCodes[index]
              ? Border.all(
                  color: ColorManager.white,
                  width: 2,
                )
              : null,
          color: Color(_colorCodes[index]),
          shape: BoxShape.circle,
        ),
        child: activeColorCode == _colorCodes[index]
            ? const Icon(
                Icons.done,
                color: ColorManager.white,
              )
            : null,
      ),
    );
  }
}
