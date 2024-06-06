abstract class WriteDataCubitStates {}

class WriteDataCubitInitialState extends WriteDataCubitStates {}

class WriteDataCubitLoadingState extends WriteDataCubitStates {}

class WriteDataCubitSuccessState extends WriteDataCubitStates {}

class WriteDataCubitFailedState extends WriteDataCubitStates {
  final String massage;
  WriteDataCubitFailedState({required this.massage});
}
