import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordstock/domain/login/login.dart';
import 'package:wordstock/repository/auth_repository.dart';

final loginFirstProvider = FutureProvider.autoDispose(
    (ref) => ref.read(authRepoProvider).getNothing());

final loginProvider =
    StateNotifierProvider.autoDispose<LoginController, AsyncValue<Login>>(
        (ref) {
  final authProvider = ref.read(authRepoProvider);
  final firstProvider = ref.watch(loginFirstProvider);

  return LoginController(authProvider, firstProvider);
});

class LoginController extends StateNotifier<AsyncValue<Login>> {
  LoginController(this.authRepo, this.firstProvider) : super(firstProvider);

  final AuthRepository authRepo;
  final AsyncValue<Login> firstProvider;

  //ログイン処理
  Future<void> loginData(String mail, String passWord) async {
    String message = await authRepo.loginUser(mail, passWord);
    if (message != 'loginOk') {
      state = AsyncValue.data(state.value!.copyWith(errorMessage: message));
    }
  }

  //エラーメッセージ初期化処理
  Future<void> flatData() async {
    state = AsyncValue.data(state.value!.copyWith(errorMessage: ''));
  }
}
