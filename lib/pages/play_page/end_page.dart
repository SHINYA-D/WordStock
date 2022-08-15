import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wordstock/model/word/word.dart';
import 'package:wordstock/pages/play_page/end_page_control.dart';

class EndPage extends ConsumerWidget {
  const EndPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Object? countList = ModalRoute.of(context)?.settings.arguments;
    if (countList == null) {
      throw Exception();
    }
    final List<dynamic> counts = countList as List<dynamic>;
    final good = counts[0];
    final bad = counts[1];
    final folderID = counts[2];
    //List<String> okList = counts[3];
    final List<String> ngList = counts[4];

    //スコア
    final double percent = (good / (good + bad)) * 100;
    final int total = percent.floor();

    //再実行ボタン表示・非表示
    bool visible = true;
    if (bad == 0) {
      visible = false;
    }

    //再実行時受け渡し変数
    List<Word>? valueNg = [];

    //共通プロバイダ
    final endsProvider = ref.watch(endProvider);

    //更新プロバイダ
    final endControlProvider = ref.read(endProvider.notifier);

/*==============================================================================
【成績表画面】
==============================================================================*/
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '単語一覧',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: SizedBox(
        height: 500.h,
        width: 430.w,
        child: Padding(
          padding: EdgeInsets.only(right: 50.w, left: 50.w, top: 60.h),
          child: Card(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(right: 50.w, left: 50.w, top: 100.h),
                child: Column(
                  children: [
                    //【成績表表示処理】
                    _score(good, bad, total),
                    //【ボタン処理】
                    Column(
                      children: [
                        //キャンセルボタン
                        SizedBox(
                          width: 200.w,
                          child: ElevatedButton(
                            onPressed: () async {
                              endControlProvider.endFlat(folderID);
                              await Navigator.of(context)
                                  .pushNamedAndRemoveUntil(
                                      "/", ModalRoute.withName("/"));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              side: const BorderSide(
                                color: Colors.black,
                                width: 1, //枠線！
                              ),
                            ),
                            child: const Text(
                              "終了",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        //再実行ボタン
                        Visibility(
                          visible: visible,
                          //maintainSize: true,
                          child: endsProvider.when(
                            data: (endsProvider) => ElevatedButton(
                              onPressed: () async {
                                final int count = endsProvider.length;
                                for (int i = 0; i < count; i++) {
                                  for (int k = 0; k < ngList.length; k++) {
                                    if (endsProvider[i].wId == ngList[k]) {
                                      valueNg.add(endsProvider[i]);
                                    }
                                  }
                                }
                                for (int i = 0; i < ngList.length; i++) {
                                  endControlProvider.endBadUp(ngList[i]);
                                }
                                //【FLAT更新】
                                endControlProvider.endFlat(folderID);
                                await Navigator.pushNamed(context, "/playpage",
                                    arguments: valueNg);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                side: const BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              child: const Text(
                                "間違えた箇所をもう一度",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            error: (error, stackTrace) =>
                                Text('エラーが発生しました。\n ${error.toString()}'),
                            loading: () => const CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*==============================================================================
【成績表表示】
==============================================================================*/
Widget _score(int good, int bad, int total) {
  return Column(
    children: [
      SizedBox(
        child: Center(
          child: Text(
            '正解率：$total' '%',
            style: const TextStyle(
              fontSize: 30,
              color: Colors.black,
            ),
          ),
        ),
      ),
      SizedBox(
        child: Center(
          child: Text(
            '正解数：$good',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
      ),
      SizedBox(
        child: Center(
          child: Text(
            '不正解数：$bad',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
      ),
    ],
  );
}
