import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wordstock/presentation/pages/folder/folder_page.dart';
import 'package:wordstock/presentation/pages/login/login_page.dart';
import 'package:wordstock/presentation/pages/login/user_registration.dart';
import 'package:wordstock/presentation/pages/play/play_page.dart';
import 'package:wordstock/presentation/pages/play/play_result_page.dart';
import 'package:wordstock/presentation/pages/word/word_edit_page.dart';
import 'package:wordstock/presentation/pages/word/word_page.dart';
import 'package:wordstock/presentation/pages/word/word_registration_page.dart';
import 'package:wordstock/presentation/parts/wordstock_theme.dart.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(431, 732),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: <String, WidgetBuilder>{
              '/': (BuildContext context) => const LoginPage(),
              //SignInPage
              '/sign_in_page': (BuildContext context) => const SignInPage(),
              '/user_registration': (BuildContext context) =>
                  const UserRegistration(),
              '/folder_page': (BuildContext context) => const FolderPage(),
              '/word_page': (BuildContext context) => const WordPage(),
              '/word_registration_page': (BuildContext context) =>
                  const WordRegistrationPage(),
              '/word_edit_page': (BuildContext context) => const WordEditPage(),
              '/play_page': (BuildContext context) => const PlayPage(),
              '/play_result_page': (BuildContext context) =>
                  const PlayResultPage(),
            },
            theme: WordStockTheme.light(),
          );
        });
  }
}
