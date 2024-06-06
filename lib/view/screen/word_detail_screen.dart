import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/word_model.dart';
import 'package:flutter_application_1/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:flutter_application_1/controllers/read_data_cubit/read_data_cubit_state.dart';
import 'package:flutter_application_1/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:flutter_application_1/view/style/color_manager.dart';
import 'package:flutter_application_1/view/widgets/exception_widget.dart';
import 'package:flutter_application_1/view/widgets/loading_widget.dart';
import 'package:flutter_application_1/view/widgets/update_word_button.dart';
import 'package:flutter_application_1/view/widgets/update_word_dialog.dart';
import 'package:flutter_application_1/view/widgets/word_info_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordDetailScreen extends StatefulWidget {
  const WordDetailScreen({super.key, required this.wordModel});

  final WordModel wordModel;

  @override
  State<WordDetailScreen> createState() => _WordDetailScreenState();
}

class _WordDetailScreenState extends State<WordDetailScreen> {
  late WordModel _wordModel;
  @override
  void initState() {
    super.initState();
    _wordModel = _wordModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _getAppBar(context),
        body: BlocBuilder<ReadDataCubit, ReadDataCubitStates>(
          builder: (context, state) {
            if (state is ReadDataCubitSuccessState) {
              int index = state.word.indexWhere((element) =>
                  element.indexAtDataBase == _wordModel.indexAtDataBase);
              _wordModel = state.word[index];
              return _getSuccessBody(context);
            } else if (state is ReadDataCubitFailedState) {
              return ExceptionWidget(
                  iconData: Icons.error, message: state.message);
            } else {
              return const LoadingWidget();
            }
          },
        ));
  }

  ListView _getSuccessBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      children: [
        _getLabelText('Word'),
        const SizedBox(height: 10),
        WordInfoWidget(
          color: Color(_wordModel.colorCode),
          isArabic: _wordModel.isArabic,
          text: _wordModel.text,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            _getLabelText('Similar Words'),
            const Spacer(),
            UpdataWordButton(
              color: Color(_wordModel.colorCode),
              onTap: () => showDialog(
                context: context,
                builder: (context) => UpdateWordDialog(
                  isExample: false,
                  colorCode: _wordModel.colorCode,
                  indexAtDataBase: _wordModel.indexAtDataBase,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        for (int i = 0; i < _wordModel.arabicWord.length; i++)
          WordInfoWidget(
            color: Color(_wordModel.colorCode),
            isArabic: true,
            text: _wordModel.arabicWord[i],
            onPressed: () => _deleteArabicWord(i),
          ),
        for (int i = 0; i < _wordModel.englishWord.length; i++)
          WordInfoWidget(
            color: Color(_wordModel.colorCode),
            isArabic: false,
            text: _wordModel.englishWord[i],
            onPressed: () => _deleteEnglishWord(i),
          ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            _getLabelText('Example'),
            const Spacer(),
            UpdataWordButton(
              color: Color(
                _wordModel.colorCode,
              ),
              onTap: () => showDialog(
                context: context,
                builder: (context) => UpdateWordDialog(
                  colorCode: _wordModel.colorCode,
                  isExample: true,
                  indexAtDataBase: _wordModel.indexAtDataBase,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        for (int i = 0; i < _wordModel.arabicExample.length; i++)
          WordInfoWidget(
            color: Color(_wordModel.colorCode),
            isArabic: true,
            text: _wordModel.arabicExample[i],
            onPressed: () => _deleteArabicExample(i),
          ),
        for (int i = 0; i < _wordModel.englishExample.length; i++)
          WordInfoWidget(
            color: Color(_wordModel.colorCode),
            isArabic: false,
            text: _wordModel.englishExample[i],
            onPressed: () => _deleteEnglishExample(i),
          ),
      ],
    );
  }

  Text _getLabelText(String label) => Text(
        label,
        style: TextStyle(
            color: Color(_wordModel.colorCode),
            fontWeight: FontWeight.bold,
            fontSize: 22),
      );

  AppBar _getAppBar(BuildContext context) => AppBar(
        foregroundColor: Color(_wordModel.colorCode),
        title: Text(
          'Word Detail',
          style: TextStyle(
            color: Color(
              _wordModel.colorCode,
            ),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _deleteWord.call(context),
            icon: Icon(
              Icons.remove,
              color: Color(_wordModel.colorCode),
            ),
          ),
        ],
      );

  void _deleteWord(BuildContext context) {
    WriteDataCubit.get(context).deleteWord(_wordModel.indexAtDataBase);
    ReadDataCubit.get(context).getWords();
    Navigator.pop(context);
  }

  void _deleteArabicWord(int index) {
    WriteDataCubit.get(context).deleteSimilarWord(
      _wordModel.indexAtDataBase,
      index,
      true,
    );
    ReadDataCubit.get(context).getWords();
  }

  void _deleteEnglishWord(int index) {
    WriteDataCubit.get(context).deleteSimilarWord(
      _wordModel.indexAtDataBase,
      index,
      false,
    );
    ReadDataCubit.get(context).getWords();
  }

  void _deleteArabicExample(int index) {
    WriteDataCubit.get(context).deleteExample(
      _wordModel.indexAtDataBase,
      index,
      true,
    );
    ReadDataCubit.get(context).getWords();
  }

  void _deleteEnglishExample(int index) {
    WriteDataCubit.get(context).deleteExample(
      _wordModel.indexAtDataBase,
      index,
      false,
    );
    ReadDataCubit.get(context).getWords();
  }
}
