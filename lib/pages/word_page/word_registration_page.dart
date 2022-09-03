import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';
import 'package:wordstock/constant/passed.dart';
import 'package:wordstock/model/word/word.dart';

import 'word_controller.dart';

class WordRegistrationPage extends ConsumerWidget {
  const WordRegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    final String folderId = args as String;

    const int cardItemCount = 5;

    final List<TextEditingController> frontTextController =
        List.generate(5, (i) => TextEditingController(text: ''));

    final List<TextEditingController> backTextController =
        List.generate(5, (i) => TextEditingController(text: ''));

    final wordsCtr = ref.read(wordProvider(folderId).notifier);
/*==============================================================================
【登録画面】
==============================================================================*/

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('カード作成'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  try {
                    _wordRegister(cardItemCount, frontTextController,
                        backTextController, folderId, wordsCtr);
                    Navigator.of(context).pop();
                  } catch (e) {
                    AlertDialog(
                      title: const Text('単語登録中にエラーが発生しました'),
                      actions: <Widget>[
                        GestureDetector(
                          child: const Text('閉じる'),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  }
                },
                child: const Text(
                  '完了',
                  style: TextStyle(color: Colors.white),
                )),
          ]),
      body: GestureDetector(
        child: ListView.builder(
          itemCount: cardItemCount,
          itemBuilder: (context, index) {
            final int x = index + 1;
            return ListTile(
              title: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20.h,
                      left: 0.w,
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                        width: 400.w,
                        height: 200.h,
                        child: Center(
                          child: Column(
                            children: [
                              Text('$x枚目のカード'),
                              _buildInputForm(frontTextController,
                                  backTextController, index),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/*==============================================================================
【フォーム画面】
==============================================================================*/
Widget _buildInputForm(List<TextEditingController> frontTextController,
    List<TextEditingController> backTextController, int index) {
  return Column(children: [
    TextField(
      maxLength: 20,
      controller: frontTextController[index],
      decoration: const InputDecoration(
        hintText: '表面の値を入力してください',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(15, 16, 15, 15)),
        ),
      ),
      autofocus: true,
    ),
    TextField(
      maxLength: 20,
      controller: backTextController[index],
      decoration: const InputDecoration(
        hintText: '裏面の値を入力してください',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(15, 16, 15, 15)),
        ),
      ),
      autofocus: true,
    ),
  ]);
}

/*==============================================================================
【登録処理】
==============================================================================*/
_wordRegister(
    int cardItemCount,
    List<TextEditingController> frontTextController,
    List<TextEditingController> backTextController,
    String? folderId,
    controlWordsProvider) {
  //TODO:Mapにできない
  for (var i = 0; i < cardItemCount; i++) {
    if ((frontTextController[i].text != "") &&
        (backTextController[i].text != "")) {
      final String uid = const Uuid().v4();
      final Word register = Word(
        id: uid,
        frontName: frontTextController[i].text,
        backName: backTextController[i].text,
        tableName: 'words',
        folderNameId: folderId,
        yesCount: 0,
        noCount: 0,
        play: 0,
        time: 0,
        percent: 0,
        average: 0,
        passed: passedJudgement(Passed.flat),
      );
      controlWordsProvider.registerData(register);
    }
  }
}
