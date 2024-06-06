import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/word_model.dart';
import 'package:flutter_application_1/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:flutter_application_1/view/screen/word_detail_screen.dart';
import 'package:flutter_application_1/view/style/color_manager.dart';

class WordItemWidget extends StatelessWidget {
  const WordItemWidget({super.key, required this.wordModel});
  final WordModel wordModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WordDetailScreen(
            wordModel: wordModel,
          ),
        ),
      ).then((value) async {
        Future.delayed(const Duration(seconds: 1)).then(
          (value) => ReadDataCubit.get(context).getWords(),
        );
      }),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: _getBoxDecoration(),
        child: Center(
          child: Text(
            wordModel.text,
            style: const TextStyle(
                color: ColorManager.white,
                fontWeight: FontWeight.bold,
                fontSize: 24),
          ),
        ),
      ),
    );
  }

  BoxDecoration _getBoxDecoration() => BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Color(wordModel.colorCode));
}
