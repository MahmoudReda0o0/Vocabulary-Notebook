import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:flutter_application_1/controllers/read_data_cubit/read_data_cubit_state.dart';
import 'package:flutter_application_1/view/style/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageFilterWidget extends StatelessWidget {
  const LanguageFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataCubitStates>(
        builder: (context, state) {
      return Text(
        _mapLanguageFilterEnumToString(
            ReadDataCubit.get(context).languageFilter),
        style: const TextStyle(
            color: ColorManager.white,
            fontSize: 21,
            fontWeight: FontWeight.bold),
      );
    });
  }

  String _mapLanguageFilterEnumToString(LanguageFilter languageFilter) {
    if (languageFilter == LanguageFilter.arabit) {
      return 'Arabic';
    } else if (languageFilter == LanguageFilter.english) {
      return 'English';
    } else {
      return 'All Words';
    }
  }
}
