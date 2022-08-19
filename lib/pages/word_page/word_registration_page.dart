import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';
import 'package:wordstock/model/word/word.dart';
import 'word_controller.dart';

class WordRegistrationPage extends ConsumerWidget {
  const WordRegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    final String folderIdNum = args as String;

    const int cardItemCount = 5;

    final List<TextEditingController> frontTextController =
        List.generate(5, (i) => TextEditingController(text: ''));

    final List<TextEditingController> backTextController =
        List.generate(5, (i) => TextEditingController(text: ''));

    final wordsCtr = ref.read(wordProvider.notifier);
/*==============================================================================
【登録画面】
==============================================================================*/

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        centerTitle: true,
        title: const Text(
          'カード作成',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
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
                      color: Colors.white70,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                        width: 400.w,
                        height: 240.h,
                        child: Center(
                          child: Column(
                            children: [
                              Text('$x枚目のカード'),
                              _buildInputForm(frontTextController,
                                  backTextController, index),
                              _buildCompletionButton(frontTextController,
                                  backTextController, index, context),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 238, 91, 117),
        onPressed: () {
          try {
            _wordRegister(cardItemCount, frontTextController,
                backTextController, folderIdNum, wordsCtr);
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
        child: const Icon(
          Icons.add_box,
          color: Colors.black,
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
【実行ボタン】
==============================================================================*/
Widget _buildCompletionButton(
    List<TextEditingController> frontTextController,
    List<TextEditingController> backTextController,
    int index,
    BuildContext context) {
  return Row(
    children: [
      Padding(
        padding: EdgeInsets.only(left: 80.w, top: 0, right: 40.w),
        child: SizedBox(
          height: 30.h,
          width: 90.w,
          child: ElevatedButton(
            onPressed: () {
              frontTextController[index].text = '';
              backTextController[index].text = '';
            },
            child: const Text("取消"),
          ),
        ),
      ),
      SizedBox(
        height: 30.h,
        width: 90.w,
        child: ElevatedButton(
          onPressed: () {
            if (frontTextController[index].text == '' ||
                backTextController[index].text == '') {
              showBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 200,
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 20,
                        )
                      ],
                    ),
                    child: const Text('未入力の箇所があります'),
                  );
                },
              );
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.of(context).pop();
              });
            } else {
              FocusScope.of(context).unfocus();
            }
          }, //onPressed
          child: const Text("完了"),
        ),
      ),
    ],
  );
}

/*==============================================================================
【登録処理】
==============================================================================*/
_wordRegister(
    int cardItemCount,
    List<TextEditingController> frontTextController,
    List<TextEditingController> backTextController,
    String? folderIdNum,
    controlWordsProvider) {
  for (var i = 0; i < cardItemCount; i++) {
    if ((frontTextController[i].text != "") &&
        (backTextController[i].text != "")) {
      final String uid = const Uuid().v4();
      final Word register = Word(
          wId: uid,
          wFrontName: frontTextController[i].text,
          wBackName: backTextController[i].text,
          wTableName: 'words',
          wFolderNameId: folderIdNum,
          wYes: 0,
          wNo: 0,
          wPlay: 0,
          wTime: 0,
          wPercent: 0,
          wAverage: 0,
          wOk: 'FLAT');

      controlWordsProvider.registerData(register);
    }
  }
  //TODO:Mapにできない
  // cardItemCount.map((cardCount){
  //   if ((frontTextController[cardCount].text != "") &&
  //       (backTextController[cardCount].text != "")) {
  //     final String uid = const Uuid().v4();
  //     final Word register = Word(
  //         wId: uid,
  //         wFrontName: frontTextController[cardCount].text,
  //         wBackName: backTextController[cardCount].text,
  //         wTableName: 'words',
  //         wFolderNameId: folderIdNum,
  //         wYes: 0,
  //         wNo: 0,
  //         wPlay: 0,
  //         wTime: 0,
  //         wPercent: 0,
  //         wAverage: 0,
  //         wOk: 'FLAT');
  //
  //     controlWordsProvider.registerData(register);
  //   }
  // }).toList();
  //
  //
}
