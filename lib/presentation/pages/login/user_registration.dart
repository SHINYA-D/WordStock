import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wordstock/domain/login/login.dart';
import 'package:wordstock/presentation/pages/folder/folder_page.dart';
import 'package:wordstock/presentation/pages/login/user_registration_controller.dart';

class UserRegistration extends ConsumerWidget {
  const UserRegistration({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) => StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const FolderPage();
          }
          return const RegistrationPage();
        },
      );
}

/*==============================================================================
【登録画面】
==============================================================================*/
class RegistrationPage extends ConsumerWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputState = ref.watch(userRegistrationProvider);
    final inputCtr = ref.watch(userRegistrationProvider.notifier);

    //メールアドレス
    final mailCtr = TextEditingController(text: inputState.value?.mail);

    //パスワード
    final passWordCtr = TextEditingController(text: inputState.value?.passWord);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'WordStock',
        ),
        //automaticallyImplyLeading: false,
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
                _buildRegistration(
                    context, inputState, inputCtr, mailCtr, passWordCtr),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*==============================================================================
【登録生成】
==============================================================================*/
Widget _buildRegistration(
    BuildContext context,
    AsyncValue<Login> inputState,
    UserRegistrationController inputCtr,
    TextEditingController mailTextCtr,
    TextEditingController passWordTextCtr) {
  return inputState.when(
    data: (inputState) {
      if (inputState.errorMessage != null &&
          inputState.errorMessage != 'newUserOK' &&
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
      return _buildRegistrationForm(
          context, inputCtr, mailTextCtr, passWordTextCtr);
    },
    error: (error, _) => AlertDialog(
      title: const Text('新規作成画面示中に発生しました。'),
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
Widget _buildRegistrationForm(
        BuildContext context,
        UserRegistrationController inputCtr,
        TextEditingController mailTextCtr,
        TextEditingController passWordTextCtr) =>

//スタックで管理する
    Column(
      children: [
        _buildTitleDecoration('登録'),
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
          width: 100.w,
          child: ElevatedButton(
            style: _buildButtonDecoration(),
            child: const Text('登録'),
            onPressed: () =>
                inputCtr.registerData(mailTextCtr.text, passWordTextCtr.text),
          ),
        ),
      ],
    );
