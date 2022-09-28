import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wordstock/domain/enum/firebase_auth_error_status.dart';
import 'package:wordstock/presentation/pages/folder_page/folder_page.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const FolderPage();
          }
          return SignInPage();
        },
      );
}

/*==============================================================================
【ログイン・新規作成画面】
==============================================================================*/
class SignInPage extends StatelessWidget {
  String em = '';
  String pw = '';

  SignInPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
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
                //TODO:画像でバックイメージ可能
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
                  _buildNewAccount(context),
                  //ログイン生成
                  _buildLogin(context),
                ],
              ),
            ),
          ],
        ),
      );
/*==============================================================================
【新規アカウント生成】
==============================================================================*/
  _buildNewAccount(BuildContext context) => Column(children: [
        _buildTitleDecoration('新規アカウント作成'),
        Padding(
          padding: EdgeInsets.only(bottom: 20.h),
          child: SizedBox(
            width: 380.w,
            child: TextFormField(
              decoration: _buildInputDecoration('メールアドレス', 'mail'),
              onChanged: (String value) {
                em = value;
              },
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
              onChanged: (String value) {
                pw = value;
              },
            ),
          ),
        ),
        SizedBox(
          width: 380.w,
          child: ElevatedButton(
            style: _buildButtonDecoration(),
            child: const Text('登録'),
            onPressed: () async {
              try {
                // メール/パスワードでユーザー登録
                final FirebaseAuth auth = FirebaseAuth.instance;
                await auth.createUserWithEmailAndPassword(
                  email: em,
                  password: pw,
                );
              } on FirebaseAuthException catch (e) {
                FirebaseAuthResultStatus result =
                    FirebaseAuthExceptionHandler.handleException(e);
                String message =
                    FirebaseAuthExceptionHandler.exceptionMessage(result);
                _buildErrorPopup(context, message);
              }
            },
          ),
        ),
      ]);
/*==============================================================================
【ログイン生成】
==============================================================================*/
  _buildLogin(BuildContext context) => Column(children: [
        _buildTitleDecoration('ログイン'),
        Padding(
          padding: EdgeInsets.only(bottom: 20.h),
          child: SizedBox(
            width: 380.w,
            child: TextFormField(
              decoration: _buildInputDecoration('メールアドレス', 'mail'),
              onChanged: (String value) {
                em = value;
              },
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
              onChanged: (String value) {
                pw = value;
              },
            ),
          ),
        ),
        SizedBox(
          width: 380.w,
          child: ElevatedButton(
            style: _buildButtonDecoration(),
            child: const Text('ログイン'),
            onPressed: () async {
              try {
                // メール/パスワードでユーザー登録
                final FirebaseAuth auth = FirebaseAuth.instance;
                await auth.signInWithEmailAndPassword(
                  email: em,
                  password: pw,
                );
              } on FirebaseAuthException catch (e) {
                FirebaseAuthResultStatus result =
                    FirebaseAuthExceptionHandler.handleException(e);
                String message =
                    FirebaseAuthExceptionHandler.exceptionMessage(result);
                _buildErrorPopup(context, message);
              }
            },
          ),
        ),
      ]);
/*==============================================================================
【エラーポップアップ生成】
==============================================================================*/
  _buildErrorPopup(BuildContext context, String errorMessage) =>
      showModalBottomSheet(
          isDismissible: true,
          //モーダルの背景の色、透過
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 80.h,
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Text(errorMessage),
              ),
            );
          });

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
}
