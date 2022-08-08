import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wordstock/dependencies/pages/folderpage_folder/main_folder_page.dart';
import 'playpage_folder/play_page.dart';
import 'wordpage_folder/word_page.dart';

main() {
  runApp(
    ProviderScope(
      child: ScreenUtilInit(
          designSize: const Size(431, 732),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              initialRoute: '/',
              routes: <String, WidgetBuilder>{
                '/': (BuildContext context) => const MainFolderPage(),
               '/wordpage': (BuildContext context) =>  const WordPage(),
               '/playpage': (BuildContext context) =>  PlayPage(),
              },
            );
          }),
    ),
  );
}

