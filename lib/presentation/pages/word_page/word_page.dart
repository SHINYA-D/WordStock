import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wordstock/domain/word/word.dart';

import 'word_controller.dart';

class WordPage extends ConsumerWidget {
  const WordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folderIdNum = ModalRoute.of(context)?.settings.arguments;
    final folderId = folderIdNum as String;

    final wordsState = ref.watch(wordProvider(folderId));

    final wordsCtr = ref.read(wordProvider(folderId).notifier);

    final animationListKey = GlobalKey<AnimatedListState>();
    const animationDuration = Duration(milliseconds: 500);

/*==============================================================================
【ワード画面】
==============================================================================*/
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('単語一覧'),
        leading: IconButton(
          onPressed: () async {
            await Navigator.of(context)
                .pushNamedAndRemoveUntil("/", ModalRoute.withName("/"));
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        actions: <Widget>[
          wordsState.when(
            data: (wordsState) => Visibility(
              visible: wordsState.isNotEmpty,
              child: TextButton(
                  onPressed: () {
                    try {
                      Navigator.pushNamed(context, "/play_page",
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
            loading: () => const CircularProgressIndicator(),
          ),
        ],
      ),
      body: SlidableAutoCloseBehavior(
        child: Padding(
          padding: EdgeInsets.only(top: 30.h),
          child: wordsState.when(
            data: (wordsState) => AnimatedList(
              key: animationListKey,
              initialItemCount: wordsState.length,
              itemBuilder: (context, index, animation) {
                return Slidable(
                  endActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          Navigator.pushNamed(context, "/word_edit_page",
                              arguments: EditBox(
                                  index,
                                  wordsState[index].folderNameId ??
                                      '引数に値が入っていません'));
                        },
                        icon: Icons.settings,
                        label: '編集',
                      ),
                      SlidableAction(
                        onPressed: (_) {
                          try {
                            animationListKey.currentState?.removeItem(
                              index,
                              (context, animation) {
                                animation.addStatusListener((listener) {
                                  if (listener == AnimationStatus.dismissed) {
                                    final selectWord = wordsState[index];
                                    wordsCtr.deleteData(selectWord);
                                  }
                                });
                                return _buildWords(index, wordsState[index],
                                    context, animation);
                              },
                              duration: animationDuration,
                            );
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
                  child:
                      _buildWords(index, wordsState[index], context, animation),
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
【フォルダの生成】
==============================================================================*/
Widget _buildWords(int index, Word words, BuildContext context,
        Animation<double> animation) =>
    SizeTransition(
      sizeFactor: animation,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 10.h),
        child: Container(
          height: 60.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.w)),
          ),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/word_edit_page",
                  arguments:
                      EditBox(index, words.folderNameId ?? '引数に値が入っていません'));
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
                  words.frontName ?? 'NULL',
                  style: const TextStyle(),
                ),
              ],
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
