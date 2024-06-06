class WordModel {
  final int indexAtDataBase;
  final String text;
  final bool isArabic;
  final int colorCode;
  final List<String> arabicWord;
  final List<String> arabicExample;
  final List<String> englishWord;
  final List<String> englishExample;

  const WordModel({
    required this.indexAtDataBase,
    required this.text,
    required this.isArabic,
    required this.colorCode,
    this.arabicExample = const [],
    this.arabicWord = const [],
    this.englishExample = const [],
    this.englishWord = const [],
  });

  WordModel decrementIndexAtDatabase() {
    return WordModel(
      indexAtDataBase: indexAtDataBase - 1,
      text: text,
      isArabic: isArabic,
      colorCode: colorCode,
      arabicExample: arabicExample,
      arabicWord: arabicWord,
      englishExample: englishExample,
      englishWord: englishWord,
    );
  }

  WordModel addSimilarWord(String text, bool isArabic) {
    List<String> newWord = _initializeWord(isArabic);
    newWord.add(text);
    return _wordModelAfterCheckNewWord(isArabic, newWord);
  }

  WordModel deleteSimilarWord(int indexAtDataBase, bool isArabic) {
    List<String> newWord = _initializeWord(isArabic);
    newWord.removeAt(indexAtDataBase);
    return _wordModelAfterCheckNewWord(isArabic, newWord);
  }

  WordModel addSimilarExample(String example, bool isArabicExample) {
    List<String> newExample = _initializeExample(isArabicExample);
    newExample.add(example);
    return _wordModelAfterCheckNewExample(newExample, isArabicExample);
  }

  WordModel deleteExample(int indexAtDataBase, bool isArabic) {
    List<String> newExample = _initializeExample(isArabic);
    newExample.removeAt(indexAtDataBase);
    return _wordModelAfterCheckNewExample(newExample, isArabic);
  }

  List<String> _initializeWord(bool isArabicWord) {
    if (isArabicWord) {
      return List.from(arabicWord);
    } else {
      return List.from(englishWord);
    }
  }

  WordModel _wordModelAfterCheckNewWord(
      bool isArabicWord, List<String> newWord) {
    return WordModel(
      indexAtDataBase: indexAtDataBase,
      text: text,
      isArabic: isArabic,
      colorCode: colorCode,
      arabicWord: isArabicWord ? newWord : arabicWord,
      englishWord: !isArabicWord ? newWord : englishWord,
      arabicExample: arabicExample,
      englishExample: englishExample,
    );
  }

  List<String> _initializeExample(bool isArabicExample) {
    if (isArabicExample) {
      return List.from(arabicExample);
    } else {
      return List.from(englishExample);
    }
  }

  WordModel _wordModelAfterCheckNewExample(
    List<String> newExample,
    bool isArabicExample,
  ) {
    return WordModel(
      indexAtDataBase: indexAtDataBase,
      text: text,
      isArabic: isArabic,
      colorCode: colorCode,
      arabicWord: arabicWord,
      englishWord: englishWord,
      arabicExample: isArabicExample ? newExample : arabicExample,
      englishExample: !isArabicExample ? newExample : englishExample,
    );
  }
}
