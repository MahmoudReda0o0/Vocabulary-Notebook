import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:flutter_application_1/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:flutter_application_1/controllers/write_data_cubit/write_data_cubit_states.dart';
import 'package:flutter_application_1/view/style/color_manager.dart';
import 'package:flutter_application_1/view/widgets/arabic_or_english_widget.dart';
import 'package:flutter_application_1/view/widgets/custom_form.dart';
import 'package:flutter_application_1/view/widgets/done_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateWordDialog extends StatefulWidget {
  const UpdateWordDialog(
      {super.key,
      required this.isExample,
      required this.colorCode,
      required this.indexAtDataBase});
  final bool isExample;
  final int colorCode;
  final int indexAtDataBase;

  @override
  State<UpdateWordDialog> createState() => _UpdateWordDialogState();
}

class _UpdateWordDialogState extends State<UpdateWordDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WriteDataCubit, WriteDataCubitStates>(
        listener: (context, state) {
      if (state is WriteDataCubitSuccessState) {
        Navigator.pop(context);
      } else if (state is WriteDataCubitFailedState) {
        _getSnackBar(context, state);
      }
    }, builder: (context, state) {
      return Dialog(
        insetPadding: const EdgeInsets.all(10),
        backgroundColor: Color(widget.colorCode),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ArabicOrEnglishWidget(
                colorCode: widget.colorCode,
                arabicIsSelected: WriteDataCubit.get(context).isArabic,
              ),
              SizedBox(height: 10),
              CustomForm(
                formKey: _formKey,
                lable: widget.isExample ? 'New Example' : 'New Simelar Word',
              ),
              DoneButton(
                colorCode: widget.colorCode,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    if (widget.isExample == true) {
                      WriteDataCubit.get(context)
                          .addExample(widget.indexAtDataBase);
                    } else {
                      WriteDataCubit.get(context)
                          .addSimilarWord(widget.indexAtDataBase);
                    }
                    ReadDataCubit.get(context).getWords();
                  }
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _getSnackBar(
      BuildContext context, WriteDataCubitFailedState state) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state.massage),
        backgroundColor: ColorManager.red,
      ),
    );
  }
}
