import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordstock/domain/folder/folder.dart';
import 'package:wordstock/domain/profile/profile.dart';

final fireRepoProvider =
    Provider.family<dynamic, String>((ref, uid) => FireRepository(uid));

class FireRepository {
  FireRepository(this.userId);
  String userId;

/*==============================================================================
【プロフィールデータ取得】
==============================================================================*/
  Future<Profile> getProfileDate() async {
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

/*==============================================================================
【プロフィール画像アップデート】
==============================================================================*/
  Future<String> updateUserImg(File file) async {
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

/*==============================================================================
【プロフィールバック画像アップデート】
==============================================================================*/
  Future<String> updateUserBackImg(File file) async {
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

/*==============================================================================
【プロフィールネームアップデート】
==============================================================================*/
  Future<void> updateUserName(String newName) async {
    final doc = FirebaseFirestore.instance.collection('user').doc(userId);
    //名前アップロード
    await doc.update({
      'userName': newName,
    });
  }

/*==============================================================================
【フォルダデータ登録】
==============================================================================*/
  Future<void> registerFolder() async {
    FirebaseFirestore.instance
        .collection('user')
        .doc(userId)
        .collection('Folder')
        .doc('folderCreateId')
        .set(
      {
        'id': 'folderCreateIdを挿入する',
        'name': '作成した名前を挿入する',
      },
    );
  }

/*==============================================================================
【フォルダデータ取得】
==============================================================================*/
  Future<Folder> getFolders(String userId) async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance
            .collection('user')
            .doc(userId)
            .collection('Folder')
            .doc('folderCreateId') //TODO//本来は自動生成で作成したIDを入れる！！
            .get();

    final Folder getFolder = Folder(id: snapshot['id'], name: snapshot['name']);

    return getFolder;
  }
}
