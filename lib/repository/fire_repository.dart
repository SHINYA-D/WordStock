import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordstock/domain/profile/profile.dart';

final fireRepoProvider = Provider((ref) => FireRepository());

class FireRepository {
  //プロフィール全データ取得
  Future<Profile> getProfileDate(String userId) async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('user').doc(userId).get();

    final Profile userProfile = Profile(
        userId: snapshot['userId'],
        userImage: snapshot['userImage'],
        backImage: snapshot['backImage'],
        userName: snapshot['userName'],
        mail: snapshot['mail'],
        pass: snapshot['pass']);

    return userProfile;
  }

  //ユーザ画像アップデート
  Future<String> updateUserImg(String userId, File file) async {
    //画像アップロード
    final ref = FirebaseStorage.instance.ref().child('images/profileImage.jpg');
    //アップロード実行
    try {
      await ref.putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
    //URL格納
    String imgURL = await ref.getDownloadURL();
    //クラウドDB パス作成
    final doc = FirebaseFirestore.instance.collection('user').doc(userId);
    //URLアップロード
    await doc.update({
      'userImage': imgURL,
    });
    return imgURL;
  }

  //ユーザバック画像アップデート
  Future<String> updateUserBackImg(String userId, File file) async {
    //画像アップロード
    final ref = FirebaseStorage.instance.ref().child('images/backImage.jpg');
    //アップロード実行
    try {
      await ref.putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
    //URL格納
    String imgURL = await ref.getDownloadURL();
    //クラウドDB パス作成
    final doc = FirebaseFirestore.instance.collection('user').doc(userId);
    //URLアップロード
    await doc.update({
      'backImage': imgURL,
    });
    return imgURL;
  }

  //ユーザーネームアップロード
  Future<void> updateUserName(String userId, String newName) async {
    final doc = FirebaseFirestore.instance.collection('user').doc(userId);
    //名前アップロード
    await doc.update({
      'userName': newName,
    });
  }
}
