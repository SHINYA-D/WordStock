import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wordstock/pages/play_page/play_result_controller.dart';

class PlayResultPage extends ConsumerWidget {
  const PlayResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Object? folderIdNum = ModalRoute.of(context)?.settings.arguments;
    final String folderId = folderIdNum as String;

    final resultState = ref.watch(resultsProvider(folderId));

    final resultCtr = ref.read(resultsProvider(folderId).notifier);

/*==============================================================================
【成績表画面】
==============================================================================*/
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('成績表'),
      ),
      body: SizedBox(
        height: 500.h,
        width: 430.w,
        child: Padding(
          padding: EdgeInsets.only(right: 50.w, left: 50.w, top: 60.h),
          child: resultState.when(
            data: (resultState) => Card(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(right: 50.w, left: 50.w, top: 100.h),
                  child: Column(
                    children: [
                      _buildScore(
                        resultState.goodCount,
                        resultState.badCount,
                        resultState.accuracyRate,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 200.w,
                            child: ElevatedButton(
                              onPressed: () async {
                                await Navigator.pushNamedAndRemoveUntil(
                                    context, "/", (_) => false);
                              },
                              style: ElevatedButton.styleFrom(
                                  side: const BorderSide(width: 1)),
                              child: const Text("終了"),
                            ),
                          ),
                          Visibility(
                            visible: resultState.visible!,
                            child: ElevatedButton(
                              onPressed: () {
                                resultCtr.resultNextPage(context);
                              },
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(width: 1),
                              ),
                              child: const Text("間違えた箇所をもう一度"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            error: (error, _) => AlertDialog(
              title: const Text('フォルダ名表示中に発生しました。'),
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
      ),
    );
  }
}

/*==============================================================================
【成績表表示】
==============================================================================*/
Widget _buildScore(good, badCount, total) {
  return Column(
    children: [
      SizedBox(
        child: Center(
          child: Text(
            '正解率：$total' '%',
            style: const TextStyle(fontSize: 30),
          ),
        ),
      ),
      SizedBox(
        child: Center(
          child: Text(
            '正解数：$good',
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
      SizedBox(
        child: Center(
          child: Text(
            '不正解数：$badCount',
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    ],
  );
}
