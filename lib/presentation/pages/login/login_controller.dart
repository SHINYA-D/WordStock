import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordstock/domain/login/login.dart';
import 'package:wordstock/repository/auth_repository.dart';

final loginFirstProvider =
    FutureProvider((ref) => ref.read(authRepoProvider).getNothing());

final loginProvider =
    StateNotifierProvider<LoginController, AsyncValue<Login>>((ref) {
  final authProvider = ref.read(authRepoProvider);
  final firstProvider = ref.watch(loginFirstProvider);

  return LoginController(authProvider, firstProvider);
});

class LoginController extends StateNotifier<AsyncValue<Login>> {
  LoginController(this.authRepo, this.firstProvider) : super(firstProvider);

  final AuthRepository authRepo;
  final AsyncValue<Login> firstProvider;

  //登録処理
  Future<String> registerData(String mail, String passWord) async {
    String message = await authRepo.registerUser(mail, passWord);
    if (message != 'newUserOK') {
      state = AsyncValue.data(state.value!.copyWith(errorMessage: message));
      message = state.value!.errorMessage!;
    }
    return message;
    // Login values = Login(mail: mail, passWord: passWord);
    // state = state.value != null
    //     ? state = AsyncValue.data(values)
    //     : state = firstProvider;
  }

  //ログイン処理
  Future<String> loginData(String mail, String passWord) async {
    String message = await authRepo.loginUser(mail, passWord);
    if (message != 'loginOk') {
      state = AsyncValue.data(state.value!.copyWith(errorMessage: message));
      message = state.value!.errorMessage!;
    }
    return message;
  }
}
