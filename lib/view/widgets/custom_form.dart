import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:flutter_application_1/view/style/color_manager.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({super.key, required this.formKey, required this.lable});
  final String lable;
  final GlobalKey<FormState> formKey;

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: TextFormField(
        autofocus: true,
        controller: textEditingController,
        minLines: 1,
        maxLines: 3,
        cursorColor: ColorManager.white,
        style: const TextStyle(color: ColorManager.white),
        decoration: _getInputDecoration(),
        onChanged: (value) => WriteDataCubit.get(context).updateText(value),
        validator: (value) {
          return _validation(value, WriteDataCubit.get(context).isArabic);
        },
      ),
    );
  }

  String? _validation(String? value, bool isArabic) {
    if (value == null || value.trim().length == 0) {
      return 'This Field has not to be empty';
    }
    for (var i = 0; i < value.length; i++) {
      CharType charType = _getCharType(value.codeUnitAt(i));
      if (charType == CharType.notValit) {
        return 'Char Number ${i + 1} is not valid';
      } else if (charType == CharType.arabic && isArabic == false) {
        return 'Char Number ${i + 1} is not Arabic ';
      } else if (charType == CharType.english && isArabic == true) {
        return 'Char Number ${i + 1} is not English';
      }
    }
  }

  CharType _getCharType(int asciiCode) {
    if ((asciiCode >= 65 && asciiCode <= 95) ||
        (asciiCode >= 97 && asciiCode <= 127)) {
      return CharType.english;
    } else if (asciiCode >= 1569 && asciiCode <= 1610) {
      return CharType.arabic;
    } else if (asciiCode == 32) {
      return CharType.space;
    }
    return CharType.notValit;
  }

  InputDecoration _getInputDecoration() {
    return InputDecoration(
      label: Text(
        widget.lable,
        style: const TextStyle(color: ColorManager.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: ColorManager.white, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: ColorManager.white, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: ColorManager.red, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: ColorManager.red, width: 2),
      ),
    );
  }
}

enum CharType {
  arabic,
  english,
  space,
  notValit,
}
