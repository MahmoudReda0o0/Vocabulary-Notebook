import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/word_type_adapter.dart';
import 'package:flutter_application_1/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:flutter_application_1/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:flutter_application_1/hive_constants.dart';
import 'package:flutter_application_1/view/screen/home.dart';
import 'package:flutter_application_1/view/style/theme_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await Hive.initFlutter();
  //Hive.registerAdapter(WordTypeAdapter());
  Hive.openBox(HiveConstants.wordBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ReadDataCubit()..getWords()),
          BlocProvider(create: (context) => WriteDataCubit())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeManager.getThemeData(),
          home: const HomeScreen(),
        ));
  }
}
