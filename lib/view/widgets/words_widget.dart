import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/word_model.dart';
import 'package:flutter_application_1/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:flutter_application_1/controllers/read_data_cubit/read_data_cubit_state.dart';
import 'package:flutter_application_1/view/widgets/exception_widget.dart';
import 'package:flutter_application_1/view/widgets/loading_widget.dart';
import 'package:flutter_application_1/view/widgets/word_item_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordsWidget extends StatelessWidget {
  const WordsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataCubitStates>(
        builder: (context, state) {
      if (state is ReadDataCubitSuccessState) {
        if (state.word.isEmpty) {
          _getEmptyWirdWidget();
        }
        return _getWordWidget(state.word);
      } else if (state is ReadDataCubitFailedState) {
        return _getFailedWidget(state.message);
      } else {
        return _getLoadingWidget();
      }
    });
  }

  Widget _getWordWidget(List<WordModel> word) {
    return GridView.builder(
      itemCount: word.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 2 / 1.5,
      ),
      itemBuilder: ((context, index) {
        return WordItemWidget(wordModel: word[index]);
      }),
    );
  }

  Widget _getEmptyWirdWidget() {
    return const ExceptionWidget(
        iconData: Icons.list_rounded, message: 'Empty Words List');
  }

  Widget _getFailedWidget(String message) {
    return ExceptionWidget(iconData: Icons.error, message: message);
  }

  Widget _getLoadingWidget() {
    return const LoadingWidget();
  }
}
