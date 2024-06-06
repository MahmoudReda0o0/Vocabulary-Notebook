import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:flutter_application_1/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:flutter_application_1/controllers/write_data_cubit/write_data_cubit_states.dart';
import 'package:flutter_application_1/view/style/color_manager.dart';
import 'package:flutter_application_1/view/widgets/arabic_or_english_widget.dart';
import 'package:flutter_application_1/view/widgets/colors_widget.dart';
import 'package:flutter_application_1/view/widgets/custom_form.dart';
import 'package:flutter_application_1/view/widgets/done_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddWordDialog extends StatefulWidget {
  const AddWordDialog({super.key});

  @override
  State<AddWordDialog> createState() => _AddWordDialogState();
}

class _AddWordDialogState extends State<AddWordDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocConsumer<WriteDataCubit, WriteDataCubitStates>(
        listener: (context, state) {
          if (state is WriteDataCubitSuccessState) {
            Navigator.pop(context);
          }
          if (state is WriteDataCubitFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              _getSnackBar(state.massage),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 750),
              color: Color(WriteDataCubit.get(context).colorCode),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ArabicOrEnglishWidget(
                      colorCode: WriteDataCubit.get(context).colorCode,
                      arabicIsSelected: WriteDataCubit.get(context).isArabic,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ColorWidget(
                        activeColorCode: WriteDataCubit.get(context).colorCode),
                    CustomForm(formKey: formKey, lable: 'New Word'),
                    DoneButton(
                      colorCode: WriteDataCubit.get(context).colorCode,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          WriteDataCubit.get(context).addWord();
                          ReadDataCubit.get(context).getWords();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  SnackBar _getSnackBar(String text) {
    return SnackBar(
      content: Text(text),
      backgroundColor: ColorManager.red,
    );
  }
}
