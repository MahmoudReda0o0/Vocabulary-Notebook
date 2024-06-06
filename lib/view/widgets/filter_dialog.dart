import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:flutter_application_1/controllers/read_data_cubit/read_data_cubit_state.dart';
import 'package:flutter_application_1/view/style/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataCubitStates>(
        builder: (context, state) {
      return Dialog(
        backgroundColor: ColorManager.black,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getLabelText('Language'),
              const SizedBox(height: 10),
              _getLanguageFilter(context),
              const SizedBox(height: 15),
              _getLabelText('Sorted By'),
              const SizedBox(height: 10),
              _getSortedByFilter(context),
              const SizedBox(height: 15),
              _getLabelText('Sorting Type'),
              const SizedBox(height: 10),
              _getSortingTypeFilter(context),
            ],
          ),
        ),
      );
    });
  }

  Widget _getLanguageFilter(BuildContext context) {
    return _getFilterField(
      label: ['Arabic', 'English', 'All Words'],
      onTaps: [
        () => ReadDataCubit.get(context)
            .updateLanguageFilter(LanguageFilter.arabit),
        () => ReadDataCubit.get(context)
            .updateLanguageFilter(LanguageFilter.english),
        () => ReadDataCubit.get(context)
            .updateLanguageFilter(LanguageFilter.allWords),
      ],
      conditionsOfAction: [
        ReadDataCubit.get(context).languageFilter == LanguageFilter.arabit,
        ReadDataCubit.get(context).languageFilter == LanguageFilter.english,
        ReadDataCubit.get(context).languageFilter == LanguageFilter.allWords,
      ],
    );
  }

  Widget _getSortedByFilter(BuildContext context) {
    return _getFilterField(
      label: ['Time', 'Word Length'],
      onTaps: [
        () => ReadDataCubit.get(context).updateSortedBy(SortedBy.time),
        () => ReadDataCubit.get(context).updateSortedBy(SortedBy.wordLength),
      ],
      conditionsOfAction: [
        ReadDataCubit.get(context).sortedBy == SortedBy.time,
        ReadDataCubit.get(context).sortedBy == SortedBy.wordLength,
      ],
    );
  }

  Widget _getSortingTypeFilter(BuildContext context) {
    return _getFilterField(
      label: ['ascending', 'descending'],
      onTaps: [
        () =>
            ReadDataCubit.get(context).updateSortingType(Sortingtype.ascending),
        () => ReadDataCubit.get(context)
            .updateSortingType(Sortingtype.descending),
      ],
      conditionsOfAction: [
        ReadDataCubit.get(context).sortingtype == Sortingtype.ascending,
        ReadDataCubit.get(context).sortingtype == Sortingtype.descending,
      ],
    );
  }

  Widget _getFilterField({
    required List<String> label,
    required List<VoidCallback> onTaps,
    required List<bool> conditionsOfAction,
  }) {
    return Row(
      children: [
        for (int i = 0; i < label.length; i++)
          InkWell(
            onTap: onTaps[i],
            child: Container(
              height: 40,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: conditionsOfAction[i]
                      ? ColorManager.white
                      : ColorManager.black,
                ),
              ),
              child: Center(
                child: Text(
                  label[i],
                  style: TextStyle(
                      color: conditionsOfAction[i]
                          ? ColorManager.black
                          : ColorManager.white),
                ),
              ),
            ),
          )
      ],
    );
  }

  Widget _getLabelText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: ColorManager.white,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }
}
