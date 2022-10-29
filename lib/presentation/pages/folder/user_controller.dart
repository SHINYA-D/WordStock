import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordstock/domain/profile/profile.dart';
import 'package:wordstock/repository/fire_repository.dart';

final profileProvider = FutureProvider.family<Profile, String>(
    (ref, uid) => ref.read(fireRepoProvider).getProfileDate(uid));

final drawerProvider =
    StateNotifierProvider.family<UserController, AsyncValue<Profile>, String>(
        (ref, uid) {
  final fireBaseRepo = ref.read(fireRepoProvider);
  final profilePro = ref.watch(profileProvider(uid));
  return UserController(profilePro, fireBaseRepo);
});

class UserController extends StateNotifier<AsyncValue<Profile>> {
  UserController(this.profilePro, this.fireBaseRepo) : super(profilePro);

  final AsyncValue<Profile> profilePro;
  final FireRepository fireBaseRepo;

  void userImage(String uid) async {
    String? imgURL;
    //選択したファイルのパスが入る
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles();
    if (pickedFile != null) {
      //File型に変換する
      File file = File(pickedFile.files.single.path!);
      //ストレージに入った写真のURLを変数に設定する
      imgURL = await fireBaseRepo.updateUserImg(uid, file);

      state = AsyncValue.data(state.value!.copyWith(userImage: imgURL));
    }
  }

  void backImage(String uid) async {
    String? imgURL;
    //選択したファイルのパスが入 る
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles();
    if (pickedFile != null) {
      //File型に変換する
      File file = File(pickedFile.files.single.path!);
      //ストレージに入った写真のURLを変数に設定する
      imgURL = await fireBaseRepo.updateUserBackImg(uid, file);
      state = AsyncValue.data(state.value!.copyWith(backImage: imgURL));
    }
  }

  void updateUserName(String uid, String newName) async {
    await fireBaseRepo.updateUserName(uid, newName);
    state = AsyncValue.data(state.value!.copyWith(userName: newName));
  }
}
