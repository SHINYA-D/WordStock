import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wordstock/pages/folder_page/folder_edit_page.dart';
import 'package:wordstock/pages/folder_page/folder_page.dart';
import 'package:wordstock/pages/play_page/play_page.dart';
import 'package:wordstock/pages/play_page/play_result_page.dart';
import 'package:wordstock/pages/word_page/word_edit_page.dart';
import 'package:wordstock/pages/word_page/word_page.dart';
import 'package:wordstock/pages/word_page/word_registration_page.dart';

main() {
  runApp(
    ProviderScope(
      child: ScreenUtilInit(
          designSize: const Size(431, 732),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, _) {
            return MaterialApp(
              initialRoute: '/',
              routes: <String, WidgetBuilder>{
                '/': (BuildContext context) => const FolderPage(),
                '/folder_edit': (BuildContext context) => const FolderEditPage(),
                '/word_page': (BuildContext context) => const WordPage(),
                '/word_registration': (BuildContext context) =>
                    const WordRegistrationPage(),
                '/word_edit': (BuildContext context) => const WordEditPage(),
                '/play_page': (BuildContext context) => const PlayPage(),
                '/end_page': (BuildContext context) => const PlayResultPage(),
              },
            );
          }),
    ),
  );
}
