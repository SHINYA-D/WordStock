import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'word_controller.dart';

class WordRegistrationPage extends ConsumerWidget {
  const WordRegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folderId = ModalRoute.of(context)?.settings.arguments as String;

    const int cardItemCount = 5;

    final List<TextEditingController> frontTextCtr =
        List.generate(5, (i) => TextEditingController(text: ''));

    final List<TextEditingController> backTextCtr =
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
                    wordsCtr.registerData(
                        cardItemCount, frontTextCtr, backTextCtr, folderId);
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
            final x = index + 1;
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
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.h, horizontal: 20.w),
                        child: SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Column(
                              children: [
                                Text('$x枚目のカード'),
                                _buildInputForm(
                                    frontTextCtr, backTextCtr, index),
                              ],
                            ),
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
Widget _buildInputForm(List<TextEditingController> frontTextCtr,
    List<TextEditingController> backTextCtr, int index) {
  return Column(children: [
    TextField(
      maxLength: 20,
      controller: frontTextCtr[index],
      decoration: const InputDecoration(
        hintText: '表面の値を入力してください',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(15, 16, 15, 15)),
        ),
      ),
    ),
    TextField(
      maxLength: 20,
      controller: backTextCtr[index],
      decoration: const InputDecoration(
        hintText: '裏面の値を入力してください',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(15, 16, 15, 15)),
        ),
      ),
    ),
  ]);
}
