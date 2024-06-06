import 'package:flutter_application_1/Model/word_model.dart';
import 'package:flutter_application_1/hive_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_application_1/controllers/read_data_cubit/read_data_cubit_state.dart';

class ReadDataCubit extends Cubit<ReadDataCubitStates> {
  static ReadDataCubit get(context) => BlocProvider.of(context);
  ReadDataCubit() : super(ReadDataCubitInitialState());

  final Box _box = Hive.box(HiveConstants.wordBox);

  LanguageFilter languageFilter = LanguageFilter.allWords;
  SortedBy sortedBy = SortedBy.time;
  Sortingtype sortingtype = Sortingtype.descending;

  void updateLanguageFilter(LanguageFilter languageFilter) {
    this.languageFilter = languageFilter;
    getWords();
  }

  void updateSortedBy(SortedBy sortedBy) {
    this.sortedBy = sortedBy;
    getWords();
  }

  void updateSortingType(Sortingtype sortingtype) {
    this.sortingtype = sortingtype;
    getWords();
  }

  void getWords() {
    emit(ReadDataCubitLoadingState());
    try {
      List<WordModel> wordToReturn =
          List.from(_box.get(HiveConstants.wordList, defaultValue: []))
              .cast<WordModel>();
      _removeUnwantedWords(wordToReturn);
      _applySorting(wordToReturn);

      emit(ReadDataCubitSuccessState(word: wordToReturn));
    } catch (e) {
      languageFilter = LanguageFilter.arabit;
      emit(ReadDataCubitFailedState(message: 'you are died'));
    }
  }

  void _removeUnwantedWords(List<WordModel> wordsToReturn) {
    if (languageFilter == LanguageFilter.allWords) return;
    for (var i = 0; i < wordsToReturn.length; i++) {
      if ((languageFilter == LanguageFilter.arabit &&
              wordsToReturn[i].isArabic == false) ||
          (languageFilter == LanguageFilter.english &&
              wordsToReturn[i].isArabic == true)) {
        wordsToReturn.removeAt(i);
        i--;
      }
    }
  }

  void _applySorting(List<WordModel> wordToReturn) {
    if (SortedBy == SortedBy.time) {
      if (sortingtype == Sortingtype.ascending) {
        return;
      } else {
        _reverse(wordToReturn);
      }
    } else {
      wordToReturn.sort(
          (WordModel a, WordModel b) => a.text.length.compareTo(b.text.length));
      if (sortingtype == Sortingtype.ascending) {
        return;
      } else {
        _reverse(wordToReturn);
      }
    }
  }

  void _reverse(List<WordModel> wordToReturn) {
    for (var i = 0; i < wordToReturn.length / 2; i++) {
      WordModel temp = wordToReturn[i];
      wordToReturn[i] = wordToReturn[wordToReturn.length + i + 1];
      wordToReturn[wordToReturn.length + i + 1] = temp;
    }
  }
}

enum LanguageFilter { arabit, english, allWords }

enum SortedBy { time, wordLength }

enum Sortingtype { ascending, descending }
