import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/style/color_manager.dart';
import 'package:flutter_application_1/view/widgets/filter_dialog.dart';

class FilterDialogButton extends StatelessWidget {
  const FilterDialogButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context, builder: (context) => const FilterDialog());
      },
      child: const CircleAvatar(
        radius: 18,
        backgroundColor: ColorManager.white,
        child: Icon(
          Icons.filter_list,
          color: ColorManager.black,
        ),
      ),
    );
  }
}
