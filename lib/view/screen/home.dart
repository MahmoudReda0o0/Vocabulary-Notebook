import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/view/style/color_manager.dart';
import 'package:flutter_application_1/view/widgets/add_word_dialog.dart';
import 'package:flutter_application_1/view/widgets/colors_widget.dart';
import 'package:flutter_application_1/view/widgets/filter_dialog_button.dart';
import 'package:flutter_application_1/view/widgets/language_filter_widget.dart';
import 'package:flutter_application_1/view/widgets/words_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _getFloatingActionButton(context),
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                FilterDialogButton(),
                Spacer(),
                LanguageFilterWidget(),
              ],
            ),
            SizedBox(height: 10),
            Expanded(child: WordsWidget())
          ],
        ),
      ),
    );
  }

  FloatingActionButton _getFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: ColorManager.white,
      onPressed: () => showDialog(
          context: context, builder: (context) => const AddWordDialog()),
      child: const Icon(
        Icons.add,
        color: ColorManager.black,
      ),
    );
  }
}
