import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wordstock/pages/folder_page/folder_edit.dart';
import 'package:wordstock/pages/folder_page/folder_page.dart';
import 'package:wordstock/pages/play_page/end_page.dart';
import 'package:wordstock/pages/play_page/play_page.dart';
import 'package:wordstock/pages/word_page/word_edit.dart';
import 'package:wordstock/pages/word_page/word_page.dart';
import 'package:wordstock/pages/word_page/word_registration.dart';

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
                '/folderedit': (BuildContext context) => const FolderEdit(),
                '/wordpage': (BuildContext context) => const WordPage(),
                '/wordregistration': (BuildContext context) =>
                    const WordRegistration(),
                '/wordedit': (BuildContext context) => const WordEdit(),
                '/playpage': (BuildContext context) => const PlayPage(),
                '/endpage': (BuildContext context) => const EndPage(),
              },
            );
          }),
    ),
  );
}
