import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wordstock/domain/login/login.dart';
import 'package:wordstock/presentation/pages/folder/folder_page.dart';
import 'package:wordstock/presentation/pages/login/login_controller.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputState = ref.watch(loginProvider);

    return inputState.when(
      data: (inputState) => StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FolderPage(snapshot.data!.uid);
          }
          return const SignInPage();
        },
      ),
      error: (error, _) => AlertDialog(
        title: const Text('フォルダ名表示中に発生しました。'),
        actions: <Widget>[
          GestureDetector(
            child: const Text('閉じる'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

/*==============================================================================
【ログイン画面】
==============================================================================*/
class SignInPage extends ConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputState = ref.watch(loginProvider);
    final inputCtr = ref.watch(loginProvider.notifier);

    //メールアドレス
    final mailTextCtr = TextEditingController(text: inputState.value?.mail);

    //パスワード
    final passWordTextCtr =
        TextEditingController(text: inputState.value?.passWord);

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
                _buildLogin(context, inputState, inputCtr, mailTextCtr,
                    passWordTextCtr),
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
Widget _buildLogin(
    BuildContext context,
    AsyncValue<Login> inputState,
    LoginController inputCtr,
    TextEditingController mailTextCtr,
    TextEditingController passWordTextCtr) {
  return inputState.when(
    data: (inputState) {
      if (inputState.errorMessage != null &&
          inputState.errorMessage != 'loginOk' &&
          inputState.errorMessage!.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Text(inputState.errorMessage!)],
                ),
              );
            },
          );
        });
      }
      return _buildLoginForm(context, inputCtr, mailTextCtr, passWordTextCtr);
    },
    error: (error, _) => AlertDialog(
      title: const Text('ログイン画面示中に発生しました。'),
      actions: <Widget>[
        GestureDetector(
          child: const Text('閉じる'),
          onTap: () async {
            Navigator.pop(context);
          },
        ),
      ],
    ),
    loading: () => const CircularProgressIndicator(),
  );
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
/*==============================================================================
【共通ボタンデザイン生成】
==============================================================================*/
Widget _buildLoginForm(
        BuildContext context,
        LoginController inputCtr,
        TextEditingController mailTextCtr,
        TextEditingController passWordTextCtr) =>
    Column(
      children: [
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
          width: 110.w,
          child: ElevatedButton(
            style: _buildButtonDecoration(),
            child: const Text('ログイン'),
            onPressed: () =>
                inputCtr.loginData(mailTextCtr.text, passWordTextCtr.text),
          ),
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
    );
