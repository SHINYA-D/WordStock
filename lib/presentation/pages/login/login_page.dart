import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wordstock/presentation/pages/folder_page/folder_page.dart';
import 'package:wordstock/presentation/pages/login/login_controller.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) => StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const FolderPage();
          }
          return const SignInPage();
        },
      );
}

/*==============================================================================
【ログイン画面】
==============================================================================*/
class SignInPage extends ConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(loginProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'WordStock',
        ),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/login.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Center(
            child: ListView(
              children: [
                //新規アカウント生成
                //_buildNewAccount(),
                //ログイン生成
                _buildLogin(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*==============================================================================
【ログイン生成】
==============================================================================*/
Widget _buildLogin() {
  return Consumer(builder: (context, ref, _) {
    final inputState = ref.watch(loginProvider);
    final inputCtr = ref.watch(loginProvider.notifier);

    //メールアドレス
    final mailTextCtr = TextEditingController(text: inputState.value?.mail);

    //パスワード
    final passWordTextCtr =
        TextEditingController(text: inputState.value?.passWord);

    return Column(children: [
      _buildTitleDecoration('ログイン'),
      Padding(
        padding: EdgeInsets.only(bottom: 20.h),
        child: SizedBox(
          width: 380.w,
          child: TextFormField(
            decoration: _buildInputDecoration('メールアドレス', 'mail'),
            controller: mailTextCtr,
          ),
        ),
      ),
      // パスワード入力
      Padding(
        padding: EdgeInsets.only(bottom: 20.h),
        child: SizedBox(
          width: 380.w,
          child: TextFormField(
            decoration: _buildInputDecoration('パスワード', 'pass'),
            controller: passWordTextCtr,
          ),
        ),
      ),
      SizedBox(
        width: 380.w,
        child: Column(
          children: [
            ElevatedButton(
              style: _buildButtonDecoration(),
              child: const Text('ログイン'),
              onPressed: () async {
                // TODO:メール/パスワードでユーザーログイン
                String messageData = await inputCtr.loginData(
                    mailTextCtr.text, passWordTextCtr.text);

                if (messageData != 'loginOk') {
                  showModalBottomSheet(
                      isDismissible: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 80.h,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Center(
                            child: Text(messageData),
                          ),
                        );
                      });
                }
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/user_registration");
              },
              child: const Text(
                '新規アカウント作成',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    ]);
  });
}

/*==============================================================================
【共通タイトルデザイン生成】
==============================================================================*/
_buildTitleDecoration(String selectTitle) => Padding(
      padding: const EdgeInsets.only(top: 50, bottom: 20),
      child: Text(
        selectTitle,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 10,
          color: Colors.white,
        ),
      ),
    );
/*==============================================================================
【共通入力デザイン生成】
==============================================================================*/
_buildInputDecoration(
  String selectHintText,
  String icon,
) =>
    InputDecoration(
      hintText: selectHintText,
      fillColor: Colors.white,
      filled: true,
      isDense: true,
      prefixIcon: icon == 'mail'
          ? const Icon(Icons.mail_outline, color: Colors.blue)
          : const Icon(Icons.https, color: Colors.blue),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
    );
/*==============================================================================
【共通ボタンデザイン生成】
==============================================================================*/
_buildButtonDecoration() => ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      elevation: 30,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    );
