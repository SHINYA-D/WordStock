import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordstock/domain/enum/firebase_auth_error_status.dart';
import 'package:wordstock/domain/login/login.dart';

final authRepoProvider = Provider((ref) => AuthRepository());

class AuthRepository {
  //初期化（空文字が入る）
  Future<Login> getNothing() async {
    Login valueNothing = Login(mail: '', passWord: '', errorMessage: '');
    return valueNothing;
  }

  //アカウント登録
  Future<String> registerUser(String mail, String passWord) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      await auth.createUserWithEmailAndPassword(
        email: mail,
        password: passWord,
      );
      return 'newUserOK';
    } on FirebaseAuthException catch (e) {
      FirebaseAuthResultStatus result =
          FirebaseAuthExceptionHandler.handleException(e);
      String message = FirebaseAuthExceptionHandler.exceptionMessage(result);
      return message;
    }
  }

//ログイン判定
  Future<String> loginUser(String mail, String passWord) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signInWithEmailAndPassword(
        email: mail,
        password: passWord,
      );
      return 'loginOk';
    } on FirebaseAuthException catch (e) {
      FirebaseAuthResultStatus result =
          FirebaseAuthExceptionHandler.handleException(e);
      String message = FirebaseAuthExceptionHandler.exceptionMessage(result);
      return message;
    }
  }
}
