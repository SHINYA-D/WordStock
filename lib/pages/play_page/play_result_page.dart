import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wordstock/model/word/word.dart';
import 'package:wordstock/pages/error_page/error_page.dart';
import 'package:wordstock/pages/play_page/play_result_controller.dart';

class PlayResultPage extends ConsumerWidget {
  const PlayResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Object? countList = ModalRoute.of(context)?.settings.arguments;
    if (countList == null) {
      throw const ErrorPage('成績表画面遷移中にエラーが発生しました');
    }
    final List<dynamic> counts = countList as List<dynamic>;
    final good = counts[0];
    final bad = counts[1];
    final folderID = counts[2];
    //TODO:成績グラフを作成時に使用
    //List<String> okList = counts[3];
    final List<String> ngList = counts[4];

    //スコア
    final double percent = (good / (good + bad)) * 100;
    final int total = percent.floor();

    //再実行ボタン表示・非表示
    bool visible = true;
    if (bad == 0) visible = false;

    //再実行時受け渡し変数
    List<Word>? valueNg = [];

    final playsState = ref.watch(endProvider);

    final playsCtr = ref.read(endProvider.notifier);

/*==============================================================================
【成績表画面】
==============================================================================*/
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '成績表',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
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
                    _buildScore(good, bad, total),
                    Column(
                      children: [
                        SizedBox(
                          width: 200.w,
                          child: ElevatedButton(
                            onPressed: () async {
                              playsCtr.endFlat(folderID);
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
                        Visibility(
                          visible: visible,
                          //maintainSize: true,
                          child: playsState.when(
                            data: (playsState) => ElevatedButton(
                              onPressed: () async {
                                try {
                                  final int count = playsState.length;
                                  //TODO:Mapにできない
                                  for (int i = 0; i < count; i++) {
                                    ngList.map((ng) {
                                      if (playsState[i].wId == ng) {
                                        valueNg.add(playsState[i]);
                                      }
                                    }).toList();
                                  }
                                  ngList.map((ngList) {
                                    playsCtr.endBadUp(ngList);
                                  }).toList();
                                  playsCtr.endFlat(folderID);
                                  await Navigator.pushNamed(
                                      context, "/play_page",
                                      arguments: valueNg);
                                } catch (e) {
                                  AlertDialog(
                                    title: const Text('再プレイでエラーが発生しました'),
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
                            error: (error, _) => AlertDialog(
                              title: const Text(''
                                  'フォルダ名入力でエラーが発生しました。'),
                              actions: <Widget>[
                                GestureDetector(
                                  child: const Text('閉じる'),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
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
Widget _buildScore(int good, int bad, int total) {
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
