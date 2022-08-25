import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wordstock/model/word/word.dart';

import 'word_controller.dart';

class WordPage extends ConsumerWidget {
  const WordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folderIdNum = ModalRoute.of(context)?.settings.arguments;
    final String folderId = folderIdNum as String;

    final wordsState = ref.watch(wordProvider(folderId));

    final wordsCtr = ref.read(wordProvider(folderId).notifier);

    //wordsCtr.getPointData(folderIdNum);

/*==============================================================================
【ワード画面】
==============================================================================*/
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '単語一覧',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: SlidableAutoCloseBehavior(
        child: Padding(
          padding: EdgeInsets.only(top: 100.h),
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
                        backgroundColor: Colors.black,
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
            loading: () => const CircularProgressIndicator(),
          ),
        ),
      ),
      floatingActionButton: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 280.w, bottom: 530.h),
            child: FloatingActionButton(
              heroTag: "btn1",
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, "/word_registration_page",
                    arguments: folderId);
              },
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5.w, bottom: 530.h),
            child: wordsState.when(
              data: (wordsState) => FloatingActionButton(
                heroTag: "btn2",
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/play_page",
                      arguments: wordsState /*folderId*/);
                },
                child: const Icon(
                  Icons.play_circle_filled,
                  color: Colors.black,
                ),
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
              loading: () => const CircularProgressIndicator(),
            ),
          ),
        ],
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
          color: Colors.white,
        ),
        child: Center(
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/word_edit_page",
                    arguments: EditBox(index, wordsProvider[0].folderNameId));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.description,
                    size: 60.sp,
                    color: Colors.black,
                  ),
                  Text(
                    wordsProvider[index].frontName ?? 'NULL',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
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
  final String? folderId;

  EditBox(this.wordSelectNum, this.folderId);
}
