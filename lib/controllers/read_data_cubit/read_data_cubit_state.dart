import 'package:flutter_application_1/Model/word_model.dart';

abstract class ReadDataCubitStates {}

class ReadDataCubitInitialState extends ReadDataCubitStates {}

class ReadDataCubitLoadingState extends ReadDataCubitStates {}

class ReadDataCubitSuccessState extends ReadDataCubitStates {
  final List<WordModel> word;
  ReadDataCubitSuccessState({required this.word});
}

class ReadDataCubitFailedState extends ReadDataCubitStates {
  final String message;
  ReadDataCubitFailedState({required this.message});
}
