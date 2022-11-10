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
  //final db =  FirebaseFirestore.instance;
  String userId;
  final collectionName = 'user';
  final subCollectionFolder = 'Folder';

/*==============================================================================
【プロフィールデータ取得】
==============================================================================*/
  Future<Profile> getProfileDate() async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance
            .collection(collectionName)
            .doc(userId)
            .get();

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
    final doc =
        FirebaseFirestore.instance.collection(collectionName).doc(userId);
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
    final doc =
        FirebaseFirestore.instance.collection(collectionName).doc(userId);
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
    final doc =
        FirebaseFirestore.instance.collection(collectionName).doc(userId);
    //名前アップロード
    await doc.update({
      'userName': newName,
    });
  }

/*==============================================================================
【フォルダデータ登録】
==============================================================================*/
  Future<void> registerFolder(Folder folder) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(userId)
        .collection(subCollectionFolder)
        .doc(folder.id)
        .set(
      {
        'id': folder.id,
        'name': folder.name,
      },
    );
  }

/*==============================================================================
【フォルダデータ取得】
==============================================================================*/
  Future<List<Folder>> getFolders() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(userId)
        .collection(subCollectionFolder)
        .get();

    final List<Folder> getFolder = snapshot.docs
        .map((doc) => Folder(id: doc['id'], name: doc['name']))
        .toList();

    return getFolder;
  }

/*==============================================================================
【フォルダデータ削除】
==============================================================================*/
  Future<void> deleteFolder(Folder folder) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(userId)
        .collection(subCollectionFolder)
        .doc(folder.id)
        .delete();
  }

/*==============================================================================
【フォルダデータ編集】
==============================================================================*/
  Future<void> updateFolder(Folder folder) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(userId)
        .collection(subCollectionFolder)
        .doc(folder.id)
        .update({
      'id': folder.id,
      'name': folder.name,
    });
  }
}
