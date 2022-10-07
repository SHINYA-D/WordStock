import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordstock/domain/login/login.dart';
import 'package:wordstock/repository/auth_repository.dart';

final registrationFirstProvider =
    FutureProvider((ref) => ref.read(authRepoProvider).getNothing());

final userRegistrationProvider =
    StateNotifierProvider<UserRegistrationController, AsyncValue<Login>>((ref) {
  final authProvider = ref.read(authRepoProvider);
  final firstProvider = ref.watch(registrationFirstProvider);

  return UserRegistrationController(authProvider, firstProvider);
});

class UserRegistrationController extends StateNotifier<AsyncValue<Login>> {
  UserRegistrationController(this.authRepo, this.firstProvider)
      : super(firstProvider);

  final AuthRepository authRepo;
  final AsyncValue<Login> firstProvider;

  //登録処理
  Future<void> registerData(String mail, String passWord) async {
    String message = await authRepo.registerUser(mail, passWord);
    if (message != 'newUserOK') {
      state = AsyncValue.data(state.value!.copyWith(errorMessage: message));
    }
  }

  //エラーメッセージ初期化処理
  Future<void> flatData() async {
    state = AsyncValue.data(state.value!.copyWith(errorMessage: ''));
  }
}
