import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:flutter_application_1/view/style/color_manager.dart';

class ArabicOrEnglishWidget extends StatelessWidget {
  const ArabicOrEnglishWidget(
      {super.key, required this.colorCode, required this.arabicIsSelected});

  final int colorCode;
  final bool arabicIsSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _getContainerDesign(true, context),
        const SizedBox(
          width: 5,
        ),
        _getContainerDesign(false, context),
      ],
    );
  }

  Widget _getContainerDesign(bool buildIsArabic, BuildContext context) {
    return InkWell(
      onTap: () => WriteDataCubit.get(context).updataIsArabic(buildIsArabic),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: ColorManager.white,
          ),
          shape: BoxShape.circle,
          color: buildIsArabic == arabicIsSelected
              ? ColorManager.white
              : Color(colorCode),
        ),
        child: Center(
          child: Text(
            buildIsArabic ? 'Ar' : 'En',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: !(buildIsArabic == arabicIsSelected)
                  ? ColorManager.white
                  : Color(colorCode),
            ),
          ),
        ),
      ),
    );
  }
}
