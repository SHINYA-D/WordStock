import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wordstock/pages/presentation/parts/loading.dart';
import 'package:wordstock/pages/word_page/word_page.dart';

import 'word_controller.dart';

class WordEditPage extends ConsumerWidget {
  const WordEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    EditBox args = ModalRoute.of(context)?.settings.arguments as EditBox;
    int wordSelectIndex = args.wordSelectNum;
    String folderId = args.folderId;

    final wordsState = ref.watch(wordProvider(folderId));

    final wordsCtr = ref.read(wordProvider(folderId).notifier);

    //入力コントローラ　表
    final frontTextController = TextEditingController(
        text: wordsState.value?[wordSelectIndex].frontName);

    //入力コントローラ　裏
    final backTextController = TextEditingController(
        text: wordsState.value?[wordSelectIndex].backName);

    final String? flont = wordsState.value?[wordSelectIndex].frontName;
    final String? back = wordsState.value?[wordSelectIndex].backName;

/*==============================================================================
【編集画面】
==============================================================================*/
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('WordStock'),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 250.h,
            child: Card(
              margin: EdgeInsets.only(
                  top: 10.h, right: 0.w, bottom: 0.h, left: 0.w),
              child: Center(
                child: Text('$flont'),
              ),
            ),
          ),
          SizedBox(
            height: 250.h,
            child: Card(
              margin: EdgeInsets.only(
                  top: 10.h, right: 0.w, bottom: 0.h, left: 0.w),
              child: Center(
                child: Text('$back'),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: const Text('カード編集'),
                  content: SingleChildScrollView(
                    child: SizedBox(
                      height: 200.h,
                      width: 150.w,
                      child: Column(
                        children: [
                          TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20)
                            ],
                            controller: frontTextController,
                            decoration: const InputDecoration(),
                            autofocus: true,
                          ),
                          TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20)
                            ],
                            controller: backTextController,
                            decoration: const InputDecoration(),
                            autofocus: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("CANCEL"),
                    ),
                    wordsState.when(
                      data: (wordsState) => ElevatedButton(
                        onPressed: () {
                          try {
                            wordsCtr.upData(
                                wordSelectIndex,
                                frontTextController.text,
                                backTextController.text);
                            Navigator.pop(context);
                          } catch (e) {
                            AlertDialog(
                              title: const Text('カード編集中にエラーが発生しました。'),
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
                        child: const Text("OK"),
                      ),
                      error: (error, _) => AlertDialog(
                        title: const Text('カード編集画面でエラーが発生しました。'),
                        actions: <Widget>[
                          GestureDetector(
                            child: const Text('閉じる'),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      loading: () => const Loading(),
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.mode_edit),
      ),
    );
  }
}
