import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/Model/word_model.dart';
import 'package:flutter_application_1/controllers/write_data_cubit/write_data_cubit_states.dart';
import 'package:flutter_application_1/hive_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class WriteDataCubit extends Cubit<WriteDataCubitStates> {
  WriteDataCubit() : super(WriteDataCubitInitialState());
  static WriteDataCubit get(context) => BlocProvider.of(context);

  final Box box = Hive.box(HiveConstants.wordBox);
  String text = '';
  bool isArabic = true;
  int colorCode = 555555;

  void updateText(String text) {
    this.text = text;
  }

  void updataIsArabic(bool isArabic) {
    this.isArabic = isArabic;
    emit(WriteDataCubitInitialState());
  }

  void updataColorCode(int colorCode) {
    this.colorCode = colorCode;
    emit(WriteDataCubitInitialState());
  }

  void addWord() {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFromDataBase();
      words.add(WordModel(
          indexAtDataBase: words.length,
          text: text,
          isArabic: isArabic,
          colorCode: colorCode));
      box.put(HiveConstants.wordList, words);
    }, 'your AddWord Code is broked bro Error ;> ');
  }

  void deleteWord(int indexAtDataBase) {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFromDataBase();
      words.removeAt(indexAtDataBase);
      for (var i = 0; i < words.length; i++) {
        words[i] = words[i].decrementIndexAtDatabase();
      }
    }, 'your DeleteWord Code is broked bro Error ;> ');
  }

  void addSimilarWord(int indexAtDataBase) {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFromDataBase();
      words[indexAtDataBase] =
          words[indexAtDataBase].addSimilarWord(text, isArabic);
      box.put(HiveConstants.wordList, words);
    }, 'your Add Similar Word Code is broked bro Error ;> ');
  }

  void addExample(int indexAtDataBase) {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFromDataBase();
      words[indexAtDataBase] =
          words[indexAtDataBase].addSimilarExample(text, isArabic);
    }, 'your Add Example Code is broked bro Error ;> ');
  }

  void deleteSimilarWord(
      int indexAtDataBase, int indexAtSimilarWord, bool isArabicSimilarWord) {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFromDataBase();
      words[indexAtDataBase] =
          words[indexAtDataBase].deleteSimilarWord(indexAtDataBase, isArabic);
      box.put(HiveConstants.wordList, words);
    }, 'your Delete Similer Word Code is broked bro Error ;> ');
  }

  void deleteExample(int indexAtDataBase, int indexAtExample, bool isArabic) {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFromDataBase();
      words[indexAtDataBase] =
          words[indexAtDataBase].deleteExample(indexAtDataBase, isArabic);
      box.put(HiveConstants.wordList, words);
    }, 'your Delete Example Code is broked bro Error ;> ');
  }

  void _tryAndCatchBlock(VoidCallback methodExcute, String massage) {
    emit(WriteDataCubitLoadingState());
    try {
      methodExcute.call();
      emit(WriteDataCubitSuccessState());
    } catch (e) {
      emit(WriteDataCubitFailedState(massage: '$massage $e'));
    }
  }

  List<WordModel> _getWordsFromDataBase() =>
      List.from(box.get(HiveConstants.wordList)).cast<WordModel>();
}
