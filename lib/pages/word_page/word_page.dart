import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wordstock/model/word/word.dart';
import 'package:wordstock/pages/presentation/parts/loading.dart';

import 'word_controller.dart';

class WordPage extends ConsumerWidget {
  const WordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folderIdNum = ModalRoute.of(context)?.settings.arguments;
    final String folderId = folderIdNum as String;

    final wordsState = ref.watch(wordProvider(folderId));

    final wordsCtr = ref.read(wordProvider(folderId).notifier);

/*==============================================================================
【ワード画面】
==============================================================================*/
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('単語一覧'),
        actions: <Widget>[
          wordsState.when(
            data: (wordsState) => Visibility(
              visible: wordsState.isNotEmpty,
              child: TextButton(
                  onPressed: () {
                    try {
                      Navigator.pushReplacementNamed(context, "/play_page",
                          arguments: wordsState);
                    } catch (e) {
                      AlertDialog(
                        title: const Text('Playページに遷移中エラーが発生しました'),
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
                    'TEST開始',
                    style: TextStyle(color: Colors.white),
                  )),
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
            loading: () => const Loading(),
          ),
        ],
      ),
      body: SlidableAutoCloseBehavior(
        child: Padding(
          padding: EdgeInsets.only(top: 30.h),
          child: wordsState.when(
            data: (wordsState) => ListView.builder(
              itemCount: wordsState.length,
              itemBuilder: (context, index) {
                return Slidable(
                  endActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (_) {
                          try {
                            final selectWord = wordsState[index];
                            wordsCtr.deleteData(selectWord);
                          } catch (e) {
                            AlertDialog(
                              title: const Text('単語削除中にエラーが発生しました'),
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
                        icon: Icons.delete,
                        label: '削除',
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: _buildFolderList(index, wordsState, context),
                  ),
                );
              },
            ),
            error: (error, _) => AlertDialog(
              title: const Text('単語画面でエラーが発生しました'),
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn1",
        onPressed: () {
          Navigator.pushNamed(context, "/word_registration_page",
              arguments: folderId);
        },
        child: const Icon(Icons.post_add),
      ),
    );
  }
}

/*==============================================================================
【フォルダリストの生成】
==============================================================================*/
Widget _buildFolderList(
        int index, List<Word> wordsProvider, BuildContext context) =>
    Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.w)),
        ),
        child: Center(
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/word_edit_page",
                    arguments: EditBox(index,
                        wordsProvider[0].folderNameId ?? '引数に値が入っていません'));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.description,
                    size: 60.sp,
                  ),
                  Text(
                    wordsProvider[index].frontName ?? 'NULL',
                    style: const TextStyle(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

class EditBox {
  final int wordSelectNum;
  final String folderId;

  EditBox(this.wordSelectNum, this.folderId);
}
